/*
Copyright © 2023 BLUEARCHIO <>
*/
package cmd

import (
	"fmt"
	"io"
	"os"

	"github.com/bluearchio/Infrastructure/services/s3"
	"github.com/spf13/cobra"
)

var (
	bucketName string
	objectName string
)

// s3Cmd represents the s3 command
var s3Cmd = &cobra.Command{
	Use:   "s3-getobject",
	Short: "A brief description of your command",
	Long:  `Get a list of buckets or create a new one. `,
	Run: func(_ *cobra.Command, _ []string) {
		svc := s3.S3Service{}
		svc.MPCConfig()
		object := svc.GetObject(bucketName, objectName)
		fmt.Println(object.Body)
		bytes, err := io.ReadAll(object.Body)

		if err != nil {
			panic(err)
		}
		file, err := os.Create(objectName)
		if err != nil {
			panic(err)
		}
		defer file.Close()
		file.Write(bytes)
	},
}

func init() {
	s3Cmd.Flags().StringVarP(&bucketName, "bucketname", "b", "", "Bucket Name")
	s3Cmd.Flags().StringVarP(&objectName, "objectname", "o", "", "Object Name")
	rootCmd.AddCommand(s3Cmd)
}
