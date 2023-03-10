/*
Copyright © 2023 BLUEARCHIO <>
*/
package cmd

import (
	"fmt"
	"strings"

	validator "github.com/bluearchio/Infrastructure/functions/parameterStore"
	"github.com/spf13/cobra"
)

var (
	repository string
	commit     string
	env        string
)

var CommitValidador = &cobra.Command{
	Use:   "validate",
	Short: "function to validate if a commit is updated in parameter store",
	Long:  `function to validate if a commit is updated in parameter store, if not, the pipeline will be stopped`,
	Run: func(_ *cobra.Command, _ []string) {
		svc := validator.ParameterStoreActions{}
		svc.IsUpdated(env, repository, commit)
	},
}
var GetRepository = &cobra.Command{
	Use:   "get-repository-name",
	Short: "Get repository name from Environment Variable",
	Long:  `Get repository name from Environment Variable`,
	Run: func(_ *cobra.Command, _ []string) {
		payload := strings.Split(repository, "/")
		fmt.Println(payload[len(payload)-1])
	},
}

func init() {
	CommitValidador.Flags().StringVarP(&repository, "repository", "r", "", "Repository name")
	GetRepository.Flags().StringVarP(&repository, "repository", "r", "", "Repository name")
	CommitValidador.Flags().StringVarP(&commit, "commit", "c", "", "Commit hash")
	CommitValidador.Flags().StringVarP(&env, "env", "e", "", "Environment name")
	rootCmd.AddCommand(CommitValidador, GetRepository)
}
