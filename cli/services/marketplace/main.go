package marketplace

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/marketplacecatalog"
	"github.com/aws/aws-sdk-go-v2/service/marketplacecatalog/types"
	"github.com/bluearchio/Infrastructure/client"
)

type MarketplacecatalogService struct {
	mp      *marketplacecatalog.Client
	Product *string
	AmiID   *string
}

func (m *MarketplacecatalogService) MPCConfig() {
	m.mp = marketplacecatalog.NewFromConfig(*client.Client())
}

// DEPRECATED METHODS
func (m *MarketplacecatalogService) StartChangeSet() *marketplacecatalog.StartChangeSetOutput {
	Details := `"{
		\"Versions\": [
			{
				\"Id\": \"example2-0000-aaaa-5ef6-7890abcdef12\",
				\"ReleaseNotes\": \"My release notes\",
				\"UpgradeInstructions\": \"N/A\",
				\"VersionTitle\": \"1.0\",
				\"CreationDate\": \"2021-03-02T00:00:00.000Z\",
				\"Sources\": [
					{
						\"Type\": \"DockerImages\",
						\"Id\": \"example3-1111-bbbb-5ef6-7890abcdef12\",
						\"Images\": [
							\"709825985650.dkr.ecr.us-east-1.amazonaws.com/some-seller-prefix/my-repo-1:some-tag\"
						],
						\"Compatibility\": {
							\"Platform\": \"Linux\"
						}
					}
				],
				\"DeliveryOptions\": [
					{
						\"Id\": \"example4-2222-cccc-2222-cccccccccccc\",
						\"Type\": \"ElasticContainerRegistry\",
						\"SourceId\": \"example3-1111-bbbb-5ef6-7890abcdef12\",
						\"Title\": \"New delivery option 1\",
						\"ShortDescription\": \"Delivery option 1\",
						\"isRecommended\": false,
						\"Compatibility\": {
							\"AWSServices\": [
								\"ECS\",
								\"EKS\"
							]
						},
						\"Instructions\": {
							\"Usage\": \"test\"
						},
						\"Recommendations\": {
							\"AdditionalArtifacts\": []
						},
						\"Visibility\": \"Limited\"
					}
				]
			}
		],
		\"Description\": {
			\"ProductTitle\": \"BlueArchio ${m.Product} Ami\",
			\"ShortDescription\": \"Cloud Monitoring AMI for Amazon EC2\",
			\"Manufacturer\": null,
			\"Visibility\": \"Limited\",
			\"AssociatedProducts\": null,
			\"LongDescription\": \"This AMI provides a powerful monitoring solution for Amazon EC2 instances. With pre-configured dashboards and alerts, you can easily monitor your application performance, resource utilization, and system health. You can also customize the monitoring setup to meet your specific needs, such as adding new metrics, configuring alarms, or integrating with third-party tools. With this AMI, you can ensure that your applications are running smoothly and efficiently on the AWS cloud.\",
			\"Sku\": \"AWS-CLOUD-AMI\",
			\"SupportDescription\": \"Need help? Contact our experts at support@bluearch.io \n\nYour purchase includes 24x7 support.\",
			\"Categories\": [
			\"Operating Systems\",
			\"Network Infrastructure\",
			\"Application Development\"
			],
			\"Highlights\": [
				\"Some highlight\"
			],
		},
		\"PromotionalResources\": {
			\"LogoUrl\": \"https://awsmp-logos.s3.amazonaws.com/PLACEHOLDER_Logo_for_Containers_products.png\",
			\"AdditionalResources\": [],
			\"Videos\": []
		},
		\"SupportInformation\": {
			\"Description\": \"Description of support information.\",
			\"Resources\": []
		},
		\"RegionAvailability\": {
			\"Regions\": [
			\"ap-south-1\",
			\"eu-west-3\",
			\"eu-north-1\",
			\"eu-west-2\",
			\"eu-west-1\",
			\"ap-northeast-2\",
			\"ap-northeast-1\",
			\"me-south-1\",
			\"ca-central-1\",
			\"sa-east-1\",
			\"ap-east-1\",
			\"ap-southeast-1\",
			\"ap-southeast-2\",
			\"eu-central-1\",
			\"us-east-1\",
			\"us-east-2\",
			\"us-west-1\",
			\"us-west-2\"
			],
			\"FutureRegionSupport\": null
		},
		\"Repositories\": [
			{
				\"Url\": \"709825985650.dkr.ecr.us-east-1.amazonaws.com/some-seller-prefix/my-repo-1\",
				\"Type\": \"ECR\"
			}
		]
	}"`

	Change := types.Change{
		ChangeType: aws.String("UpdateInformation"),
		// ChangeName: aws.String("AddRevisions"),
		ChangeName: aws.String("UpdateProductInformation"),
		Entity: &types.Entity{
			Type:       aws.String("AmiProduct@1.0"),
			Identifier: aws.String(*m.AmiID),
		},
		Details: aws.String(Details),
	}
	StartChangeSetInput := &marketplacecatalog.StartChangeSetInput{
		Catalog:       aws.String("AWSMarketplace"),
		ChangeSetName: aws.String(*m.AmiID),
		ChangeSet:     []types.Change{Change},
	}

	payload, error := m.mp.StartChangeSet(context.TODO(), StartChangeSetInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (m *MarketplacecatalogService) ListChangeSets() (*marketplacecatalog.ListChangeSetsOutput, error) {
	ListChangeSetsInput := &marketplacecatalog.ListChangeSetsInput{
		Catalog: aws.String("AWSMarketplace"),
	}
	payload, error := m.mp.ListChangeSets(context.TODO(), ListChangeSetsInput)

	if error != nil {
		fmt.Println(error)
		return nil, error
	}

	return payload, nil
}
func (m *MarketplacecatalogService) CancelChangeSet(catalog, ChangeSetId string) *marketplacecatalog.CancelChangeSetOutput {
	CancelChangeSetInput := &marketplacecatalog.CancelChangeSetInput{
		Catalog:     aws.String(catalog),
		ChangeSetId: aws.String(ChangeSetId),
	}

	payload, error := m.mp.CancelChangeSet(context.TODO(), CancelChangeSetInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (m *MarketplacecatalogService) DescribeChangeSet(catalog, ChangeSetId string) *marketplacecatalog.DescribeChangeSetOutput {
	DescribeChangeSetInput := &marketplacecatalog.DescribeChangeSetInput{
		Catalog:     aws.String(catalog),
		ChangeSetId: aws.String(ChangeSetId),
	}

	payload, error := m.mp.DescribeChangeSet(context.TODO(), DescribeChangeSetInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (m *MarketplacecatalogService) TagResource(region, accountID, catalog, changeSetId string) *marketplacecatalog.TagResourceOutput {

	CommitChangeSetInput := &marketplacecatalog.TagResourceInput{
		ResourceArn: aws.String("arn:aws:marketplace-catalog:" + region + ":" + accountID + ":changeSet/" + catalog + "/" + changeSetId),
	}

	payload, error := m.mp.TagResource(context.TODO(), CommitChangeSetInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}
func (m *MarketplacecatalogService) ListEntities(catalog string, entityType *string) *marketplacecatalog.ListEntitiesOutput {
	ListEntitiesInput := &marketplacecatalog.ListEntitiesInput{
		Catalog:    aws.String(catalog),
		EntityType: aws.String(*entityType),
	}

	payload, error := m.mp.ListEntities(context.TODO(), ListEntitiesInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (m *MarketplacecatalogService) DescribeEntity(catalog, entityId string) *marketplacecatalog.DescribeEntityOutput {
	DescribeEntityInput := &marketplacecatalog.DescribeEntityInput{
		Catalog:  aws.String(catalog),
		EntityId: aws.String(entityId),
	}

	payload, error := m.mp.DescribeEntity(context.TODO(), DescribeEntityInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}

// NEW VERSION METHODS
func (m *MarketplacecatalogService) StartChangeSet2(startChangeInput *marketplacecatalog.StartChangeSetInput) (*marketplacecatalog.StartChangeSetOutput, error) {

	payload, err := m.mp.StartChangeSet(context.TODO(), startChangeInput)
	return payload, err
}
func (m *MarketplacecatalogService) DescribeEntity2(describeEntitiesInput *marketplacecatalog.DescribeEntityInput) (*marketplacecatalog.DescribeEntityOutput, error) {

	payload, err := m.mp.DescribeEntity(context.TODO(), describeEntitiesInput)
	return payload, err
}
func (m *MarketplacecatalogService) ListEntities2(listEntitiesInput *marketplacecatalog.ListEntitiesInput) (*marketplacecatalog.ListEntitiesOutput, error) {

	payload, err := m.mp.ListEntities(context.TODO(), listEntitiesInput)
	return payload, err
}
