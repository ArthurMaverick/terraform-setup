package marketplace

import (
	"time"
)

type EntityDetails struct {
	Versions []struct {
		ID                  string    `json:"Id"`
		ReleaseNotes        string    `json:"ReleaseNotes"`
		UpgradeInstructions string    `json:"UpgradeInstructions"`
		VersionTitle        string    `json:"VersionTitle"`
		CreationDate        time.Time `json:"CreationDate"`
		Sources             []struct {
			Type          string   `json:"Type"`
			ID            string   `json:"Id"`
			Images        []string `json:"Images"`
			Compatibility struct {
				Platform string `json:"Platform"`
			} `json:"Compatibility"`
		} `json:"Sources"`
		DeliveryOptions []struct {
			ID               string `json:"Id"`
			Type             string `json:"Type"`
			SourceID         string `json:"SourceId"`
			Title            string `json:"Title"`
			ShortDescription string `json:"ShortDescription"`
			IsRecommended    bool   `json:"isRecommended"`
			Compatibility    struct {
				AWSServices []string `json:"AWSServices"`
			} `json:"Compatibility"`
			Instructions struct {
				Usage string `json:"Usage"`
			} `json:"Instructions"`
			Recommendations struct {
				DeploymentResources []struct {
					Text string `json:"Text"`
					URL  string `json:"Url"`
				} `json:"DeploymentResources"`
			} `json:"Recommendations"`
			Visibility string `json:"Visibility"`
		} `json:"DeliveryOptions"`
	} `json:"Versions"`
	Description struct {
		Highlights         []string `json:"Highlights"`
		LongDescription    string   `json:"LongDescription"`
		ProductCode        string   `json:"ProductCode"`
		Manufacturer       any      `json:"Manufacturer"`
		ProductState       string   `json:"ProductState"`
		Visibility         string   `json:"Visibility"`
		AssociatedProducts any      `json:"AssociatedProducts"`
		Sku                any      `json:"Sku"`
		SearchKeywords     []string `json:"SearchKeywords"`
		ProductTitle       string   `json:"ProductTitle"`
		ShortDescription   string   `json:"ShortDescription"`
		Categories         []string `json:"Categories"`
	} `json:"Description"`
	Targeting struct {
		PositiveTargeting struct {
			BuyerAccounts []string `json:"BuyerAccounts"`
		} `json:"PositiveTargeting"`
	} `json:"Targeting"`
	PromotionalResources struct {
		PromotionalMedia    any    `json:"PromotionalMedia"`
		LogoURL             string `json:"LogoUrl"`
		AdditionalResources []struct {
			Type string `json:"Type"`
			Text string `json:"Text"`
			URL  string `json:"Url"`
		} `json:"AdditionalResources"`
		Videos []struct {
			Type  string `json:"Type"`
			Title string `json:"Title"`
			URL   string `json:"Url"`
		} `json:"Videos"`
	} `json:"PromotionalResources"`
	Dimensions []struct {
		Types       []string `json:"Types"`
		Description string   `json:"Description"`
		Unit        string   `json:"Unit"`
		Key         string   `json:"Key"`
		Name        string   `json:"Name"`
	} `json:"Dimensions"`
	SupportInformation struct {
		Description string `json:"Description"`
		Resources   []any  `json:"Resources"`
	} `json:"SupportInformation"`
	RegionAvailability struct {
		Restrict            []any    `json:"Restrict"`
		Regions             []string `json:"Regions"`
		FutureRegionSupport any      `json:"FutureRegionSupport"`
	} `json:"RegionAvailability"`
	Repositories []struct {
		URL  string `json:"Url"`
		Type string `json:"Type"`
	} `json:"Repositories"`
}
