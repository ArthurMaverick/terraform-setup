/*
Copyright © 2023 BLUEARCHIO
*/
package cmd

import (
	"fmt"
	"os"

	fn "github.com/bluearchio/Infrastructure/functions/marketplace"
	"github.com/spf13/cobra"
)

func dumpVersionCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "dump-versions [product]",
		Short: "Dump marketplace catalog data for all product versions to the all-versions.yaml YAML file",
		Args:  cobra.ExactArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			productName = args[0]
			m := fn.MarketplaceActions{
				ProductName: &productName,
			}
			m.Config()
			err := m.DumpVersions()
			if err != nil {
				return err
			}
			return nil
		},
	}
	return cmd
}
func addVersionCmd() *cobra.Command {
	var noOp bool
	cmd := &cobra.Command{
		Use:   "push-version [product] [version]",
		Short: "Push local state of the product version's YAML file into a new version",
		Args:  cobra.ExactArgs(2),
		RunE: func(_ *cobra.Command, args []string) error {
			productName := args[0]
			version := args[1]
			m := fn.MarketplaceActions{
				ProductName: &productName,
			}
			m.Config()
			return m.PushNewVersion(noOp, version)
		},
	}
	cmd.Flags().BoolVar(&noOp, "no-op", false, "Do not actually push the version, just print the change set")
	return cmd
}
func dumpProductCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "dump-product [product]",
		Short: "Dump marketplace catalog data for the product to the product.yaml YAML file",
		Args:  cobra.ExactArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			productName := args[0]
			m := fn.MarketplaceActions{
				ProductName: &productName,
			}
			m.Config()
			return m.DumpProduct()
		},
	}
	return cmd
}
func listProductsCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "list [product-type]",
		Short: "List all my AWS Marketplace products of a given type, such as AmiProduct",
		Args:  cobra.ExactArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			productType := args[0]
			m := fn.MarketplaceActions{}
			m.Config()
			return m.ListProducts(productType)
		},
	}
	return cmd
}
func updateProductCmd() *cobra.Command {
	var noOp bool
	cmd := &cobra.Command{
		Use:   "update [product]",
		Short: "Update a product's information based on the data provided in its local YAML representation",
		Args:  cobra.ExactArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			productName := args[0]
			m := fn.MarketplaceActions{
				ProductName: &productName,
			}
			m.Config()
			return m.UpdateProduct(noOp)
		},
	}
	cmd.Flags().BoolVar(&noOp, "no-op", false, "Print the changeset JSON to stdout without creating the changeset")
	return cmd
}
func cloneProductCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   "clone [product] [src-version] [dst-version]",
		Short: "Copy the YAML data from the src version to the dst version",
		Args:  cobra.ExactArgs(3),
		RunE: func(_ *cobra.Command, args []string) error {
			productName, srcVersion, dstVersion := args[0], args[1], args[2]
			m := fn.MarketplaceActions{
				ProductName: &productName,
			}
			return m.CloneProductVersion(srcVersion, dstVersion)
		},
	}
	return cmd
}

func init() {
	rootCmd := &cobra.Command{Use: "aws-marketplace"}
	rootCmd.AddCommand(
		dumpVersionCmd(),
		addVersionCmd(),
		dumpProductCmd(),
		listProductsCmd(),
		updateProductCmd(),
		cloneProductCmd(),
	)
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
