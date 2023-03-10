package marketplace

import (
	"time"
)

type YAMLVersionData struct {
	ID                  string            `json:"id"`
	Releasenotes        string            `json:"releasenotes"`
	Upgradeinstructions string            `json:"upgradeinstructions"`
	Versiontitle        string            `json:"versiontitle"`
	Creationdate        time.Time         `json:"creationdate"`
	Sources             []Sources         `json:"sources"`
	Deliveryoptions     []Deliveryoptions `json:"deliveryoptions"`
}
type PlatformCompatibility struct {
	Platform string `json:"platform"`
}
type Sources struct {
	Type          string                `json:"type"`
	ID            string                `json:"id"`
	Images        []string              `json:"images"`
	Compatibility ServicesCompatibility `json:"compatibility"`
}
type ServicesCompatibility struct {
	Awsservices []string `json:"awsservices"`
}
type Instructions struct {
	Usage string `json:"usage"`
}
type Deploymentresources struct {
	Text string `json:"text"`
	URL  string `json:"url"`
}
type Recommendations struct {
	Deploymentresources []Deploymentresources `json:"deploymentresources"`
}
type Deliveryoptions struct {
	ID               string                `json:"id"`
	Type             string                `json:"type"`
	Sourceid         string                `json:"sourceid"`
	Title            string                `json:"title"`
	Shortdescription string                `json:"shortdescription"`
	Isrecommended    bool                  `json:"isrecommended"`
	Compatibility    ServicesCompatibility `json:"compatibility"`
	Instructions     Instructions          `json:"instructions"`
	Recommendations  Recommendations       `json:"recommendations"`
	Visibility       string                `json:"visibility"`
}

// destination data structure
type DstVersionData struct {
	Version         Version           `json:"Version"`
	DeliveryOptions []DeliveryOptions `json:"DeliveryOptions"`
}
type Version struct {
	ReleaseNotes string `json:"ReleaseNotes"`
	VersionTitle string `json:"VersionTitle"`
}
type DeploymentResources struct {
	Name string `json:"Name"`
	URL  string `json:"Url"`
}
type EcrDeliveryOptionDetails struct {
	DeploymentResources []DeploymentResources `json:"DeploymentResources"`
	CompatibleServices  []string              `json:"CompatibleServices"`
	ContainerImages     []string              `json:"ContainerImages"`
	Description         string                `json:"Description"`
	UsageInstructions   string                `json:"UsageInstructions"`
}
type Details struct {
	EcrDeliveryOptionDetails EcrDeliveryOptionDetails `json:"EcrDeliveryOptionDetails"`
}
type DeliveryOptions struct {
	Details             Details `json:"Details"`
	DeliveryOptionTitle string  `json:"DeliveryOptionTitle"`
}
