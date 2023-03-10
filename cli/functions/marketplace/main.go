package marketplace

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"

	"os"
	"path/filepath"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/marketplacecatalog"
	"github.com/aws/aws-sdk-go-v2/service/marketplacecatalog/types"
	"github.com/bluearchio/Infrastructure/services/marketplace"
	"gopkg.in/yaml.v2"
)

type MarketplaceActions struct {
	svc         *marketplace.MarketplacecatalogService
	ProductName *string
}

func (m *MarketplaceActions) Config() {
	m.svc = &marketplace.MarketplacecatalogService{}
	m.svc.MPCConfig()
}

// ------------------------
// Marketplace Actions
// ------------------------
func (m *MarketplaceActions) ListProducts(productType string) error {
	params := &marketplacecatalog.ListEntitiesInput{
		Catalog:    aws.String("AWSMarketplace"),
		EntityType: aws.String(productType),
		MaxResults: aws.Int32(10),
	}
	res, err := m.svc.ListEntities2(params)
	if err != nil {
		return err
	}

	if len(res.EntitySummaryList) == 0 {
		return errors.New("could not find any products")
	}

	for _, entity := range res.EntitySummaryList {
		fmt.Printf("%s\n", *entity.Name)

		if res.NextToken == nil {
			break
		}
		params.NextToken = res.NextToken
	}

	return nil
}
func (m *MarketplaceActions) GetProductEntityID() (*string, error) {
	params := &marketplacecatalog.ListEntitiesInput{
		Catalog:    aws.String("AWSMarketplace"),
		EntityType: aws.String("AmiProduct"),
	}
	res, err := m.svc.ListEntities2(params)
	if err != nil {
		return nil, err
	}

	if len(res.EntitySummaryList) == 0 {
		return nil, fmt.Errorf("could not find entity ID for product %s", *m.ProductName)
	}

	for _, entity := range res.EntitySummaryList {
		if *entity.EntityType == *m.ProductName {
			return entity.EntityId, nil
		}
	}
	return nil, errors.New("entity not found")
}
func (m *MarketplaceActions) GetYamlPath(subdir, fileName, filename string) string {
	dirName := fmt.Sprintf("data/%s/%s", *m.ProductName, subdir)
	os.MkdirAll(dirName, os.FileMode(0755))
	return filepath.Join(dirName, fileName+".yaml")
}
func (m *MarketplaceActions) DumpProduct() error {

	entityID, err := m.GetProductEntityID()
	if err == nil {
		fmt.Println("could not find entity ID for product")
		return err
	}

	resp, err := m.svc.DescribeEntity2(&marketplacecatalog.DescribeEntityInput{
		EntityId: entityID,
		Catalog:  aws.String("AWSMarketplace"),
	})
	if err != nil {
		return err
	}
	fmt.Printf("DescribeEntity details: #####%s#####\n", *resp.Details)

	// Map to struct with all current details
	var details EntityDetails
	if err := json.Unmarshal([]byte(*resp.Details), &details); err != nil {
		return err
	}
	fileName := m.GetYamlPath(*m.ProductName, "", "description")
	data, err := yaml.Marshal(details)
	if err != nil {
		return err
	}
	// Check if file has changed berfore writing
	if _, err := os.Stat(fileName); err == nil {
		existingData, err := os.ReadFile(fileName)
		if err != nil {
			return err
		}
		if bytes.Equal(existingData, data) {
			fmt.Printf("Data for entity %s has not changed %s \n", *entityID, data)
			return nil
		}
	}

	if err := os.WriteFile(fileName, data, 0644); err != nil {
		return err
	}

	fmt.Printf("Data written to %s\n", fileName)
	return nil
}
func (m *MarketplaceActions) UpdateProduct(noOp bool) error {
	entityID, err := m.GetProductEntityID()
	if err != nil {
		return err
	}

	// Read in the yaml file
	data, err := os.ReadFile(m.GetYamlPath(*m.ProductName, "", "description"))
	if err != nil {
		return err
	}

	var details EntityDetails
	if err := yaml.Unmarshal(data, &details); err != nil {
		return err
	}

	detailsBytes, err := json.Marshal(details.Description)

	if err != nil {
		return err
	}

	change := types.Change{
		ChangeType: aws.String("UpdateInformation"),
		ChangeName: aws.String("UpdateProductInformation"),
		Entity: &types.Entity{
			Type:       aws.String("AmiProduct@1.0"),
			Identifier: entityID,
		},
		Details: aws.String(string(detailsBytes)),
	}

	changeSetInput := &marketplacecatalog.StartChangeSetInput{
		Catalog: aws.String("AWSMarketplace"),
		ChangeSet: []types.Change{
			change,
		},
	}

	if noOp {
		changeSetJSON, _ := json.MarshalIndent(changeSetInput, "", "  ")
		fmt.Println(string(changeSetJSON))
		return nil
	}

	_, err = m.svc.StartChangeSet2(changeSetInput)

	if err != nil {
		return errors.New("could not start change set: " + err.Error())
	}

	fmt.Printf("Changeset created for product %s with entity ID %s\n", *m.ProductName, *entityID)
	return nil
}

// ------------------------
// Marketplace Versions
// ------------------------
func (src YAMLVersionData) ConvertToDst() DstVersionData {
	var dst DstVersionData
	var deliveryOptions []DeliveryOptions
	var version Version

	// set version fields
	version.ReleaseNotes = src.Releasenotes
	version.VersionTitle = src.Versiontitle

	// set delivery options fields
	for _, deliveryOption := range src.Deliveryoptions {
		var d DeliveryOptions
		var details Details

		d.DeliveryOptionTitle = deliveryOption.Title

		// set EcrDeliveryOptionDetails fields
		details.EcrDeliveryOptionDetails.Description = deliveryOption.Shortdescription
		details.EcrDeliveryOptionDetails.UsageInstructions = deliveryOption.Instructions.Usage
		details.EcrDeliveryOptionDetails.ContainerImages = src.Sources[0].Images
		details.EcrDeliveryOptionDetails.CompatibleServices = deliveryOption.Compatibility.Awsservices

		for _, deploymentResource := range deliveryOption.Recommendations.Deploymentresources {
			details.EcrDeliveryOptionDetails.DeploymentResources = append(details.EcrDeliveryOptionDetails.DeploymentResources, DeploymentResources{
				Name: deploymentResource.Text,
				URL:  deploymentResource.URL,
			})
		}

		d.Details = details

		deliveryOptions = append(deliveryOptions, d)
	}

	dst.Version = version
	dst.DeliveryOptions = deliveryOptions

	return dst
}
func (m *MarketplaceActions) GetYAMLData(fileName string) (*YAMLVersionData, error) {
	yamlFile, err := os.ReadFile(fileName)
	if err != nil {
		return nil, err
	}
	var data YAMLVersionData
	if err := yaml.Unmarshal(yamlFile, &data); err != nil {
		return nil, err
	}
	return &data, nil
}
func (m *MarketplaceActions) DumpVersions() error {

	entityID, err := m.GetProductEntityID()

	if err != nil {
		return err
	}

	resp, err := m.svc.DescribeEntity2(&marketplacecatalog.DescribeEntityInput{
		EntityId: entityID,
		Catalog:  aws.String("AWSMarketplace"),
	})

	if err != nil {
		return err
	}

	var details EntityDetails
	if err := json.Unmarshal([]byte(*resp.Details), &details); err != nil {
		return err
	}

	for _, version := range details.Versions {

		fileName := m.GetYamlPath(*m.ProductName, "versions", version.VersionTitle)
		data, err := yaml.Marshal(version)
		if err != nil {
			return err
		}

		// Check if file has changed before writing to it
		if _, err := os.Stat(fileName); err == nil {
			existingData, err := os.ReadFile(fileName)
			if err != nil {
				return err
			}
			if bytes.Equal(existingData, data) {
				fmt.Printf("Data for entity %s has not changed %s \n", *entityID, data)
				return nil
			}
		}
		if err := os.WriteFile(fileName, data, 0644); err != nil {
			return err
		}

		fmt.Printf("Data written to %s\n", fileName)
	}
	return nil
}
func (m *MarketplaceActions) PushNewVersion(noOp bool, version string) error {

	entityID, err := m.GetProductEntityID()

	if err != nil {
		return err
	}

	srcVersionDetails, err := m.GetYAMLData(m.GetYamlPath(*m.ProductName, "versions", version))

	if err != nil {
		return errors.New("could not read version details: " + err.Error())
	}

	dstVersionDetails := srcVersionDetails.ConvertToDst()

	versionBytes, err := json.Marshal(dstVersionDetails)
	if err != nil {
		return err
	}

	if noOp {
		changeSetJSON, _ := json.MarshalIndent(dstVersionDetails, "", "  ")
		fmt.Println(string(changeSetJSON))
		return nil
	}

	// Create a changeset to update the product
	change := types.Change{
		ChangeType: aws.String("AddDeliveryOptions"),
		ChangeName: aws.String("AddNewVersion"),
		Entity: &types.Entity{
			Type:       aws.String("ContainerProduct@1.0"),
			Identifier: entityID,
		},
		Details: aws.String(string(versionBytes)),
	}
	changeSetInput := &marketplacecatalog.StartChangeSetInput{
		Catalog: aws.String("AWSMarketplace"),
		ChangeSet: []types.Change{
			change,
		},
	}

	if noOp {
		changeSetJSON, _ := json.MarshalIndent(changeSetInput, "", "  ")
		fmt.Println(string(changeSetJSON))
		return nil
	}

	_, err = m.svc.StartChangeSet2(changeSetInput)
	if err != nil {
		return errors.New("could not start change set: " + err.Error())
	}

	fmt.Printf("Changeset created for product %s with entity ID %s\n", *m.ProductName, *entityID)
	return nil
}
func (m *MarketplaceActions) CloneProductVersion(srcVersion, dstVersion string) error {
	srcFilePath := m.GetYamlPath(*m.ProductName, "versions", srcVersion)
	dstFilePath := m.GetYamlPath(*m.ProductName, "versions", dstVersion)

	if _, err := os.Stat(dstFilePath); err == nil {
		existingData, err := os.ReadFile(dstFilePath)
		if err != nil {
			return err
		}
		srcData, err := os.ReadFile(srcFilePath)
		if err != nil {
			return err
		}
		if bytes.Equal(existingData, srcData) {
			fmt.Printf("Data for product %s version %s has not changed\n", *m.ProductName, srcVersion)
			return nil
		}
	}

	input, err := os.ReadFile(srcFilePath)
	if err != nil {
		return err
	}
	err = os.WriteFile(dstFilePath, input, 0644)
	if err != nil {
		return err
	}

	fmt.Printf("Data written to %s\n", dstFilePath)
	return nil
}
