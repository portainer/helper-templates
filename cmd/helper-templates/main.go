package main

import (
	"encoding/json"
	helper_templates "github.com/portainer/helper-templates"
	"io/ioutil"
	"log"
	"os"
	"path"
)

type newTemplateFormat struct {
	Version   string        `json:"version"`
	Templates []interface{} `json:"templates"`
}

func main() {
	templatesFile := path.Join(helper_templates.SrcPath, "templates.json")

	if _, err := os.Stat(templatesFile); err != nil {
		if os.IsNotExist(err) {
			log.Fatalf("Unable to locate %s on disk", templatesFile)
		}
		log.Fatalf("Unable to verify template file existence, err: %s", err)
	}

	jsonFile, err := os.Open(templatesFile)
	if err != nil {
		log.Fatalf("Unable to open %s, err: %s", templatesFile, err)
	}
	defer jsonFile.Close()

	jsonData, err := ioutil.ReadAll(jsonFile)
	if err != nil {
		log.Fatalf("Unable to read %s content, err: %s", templatesFile, err)
	}

	var result []interface{}
	err = json.Unmarshal([]byte(jsonData), &result)
	if err != nil {
		log.Fatalf("Unable to parse %s content, err: %s", templatesFile, err)
	}

	newTemplateFileContent := newTemplateFormat{
		Version:   "2",
		Templates: result,
	}

	newTemplateJsonData, err := json.MarshalIndent(newTemplateFileContent, "", "\t")
	if err != nil {
		log.Fatalf("Unable to create new template file, err: %s", err)
	}

	newTemplatesFile := path.Join(helper_templates.DistPath, "templates-upgraded.json")

	err = ioutil.WriteFile(newTemplatesFile, newTemplateJsonData, os.ModePerm)
	if err != nil {
		log.Fatalf("Unable to write %s file on disk, err: %s", newTemplatesFile, err)
	}

	log.Printf("New template file successfully created at %s", newTemplatesFile)
}
