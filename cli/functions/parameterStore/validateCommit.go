package ssm

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/bluearchio/Infrastructure/services/ssm"
)

type ParameterStoreActions struct {
	commit     *string
	repository *string
	env        *string
	status     *string
	svc        *ssm.SSMService
}

// public methods
func (p *ParameterStoreActions) IsUpdated(env, repository, commit string) string {
	p.repository = &repository
	p.commit = &commit
	p.env = &env
	p.parameterStoreService()
	p.handlerRepositoryValue()
	err := p.commitStatus()

	if err != nil {
		log.Printf("Error: %s", err)
	}

	p.updateValue()
	return *p.status
}

// private methods
func (p *ParameterStoreActions) parameterStoreService() {
	p.svc = &ssm.SSMService{}
	p.svc.MPCConfig()
}
func (p *ParameterStoreActions) handlerRepositoryValue() {
	payload := strings.Split(*p.repository, "/")
	treatedValue := fmt.Sprintf("/%s/CODEBUILD/%s", strings.ToUpper(*p.env), payload[len(payload)-1])
	p.repository = &treatedValue
}
func (p *ParameterStoreActions) commitStatus() error {
	var status = ""
	latestVersionValue := p.svc.GetParameter(*p.repository)

	if *latestVersionValue.Parameter.Value == *p.commit {
		status = "NOT CHANGED"
		p.status = &status
		return nil
	}

	if *latestVersionValue.Parameter.Value != *p.commit {
		status = "CHANGED"
		p.status = &status
		return nil
	}

	return os.ErrNotExist
}
func (p *ParameterStoreActions) updateValue() error {
	if *p.status == "NOT CHANGED" {
		fmt.Println("NOT CHANGED")
	}
	if *p.status == "CHANGED" {
		fmt.Println("CHANGED")
		p.svc.PutParameter(*p.repository, *p.commit)
		return nil
	}
	return os.ErrNotExist
}
