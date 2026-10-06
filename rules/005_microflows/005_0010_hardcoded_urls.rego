# METADATA
# scope: package
# title: Hard-coded URL in microflow
# description: URLs written into REST calls or expressions differ between environments (dev, test, production) and must be edited in the model to change.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/constants/
# custom:
#  category: Maintainability
#  rulename: HardcodedUrls
#  severity: MEDIUM
#  rulenumber: "005_0010"
#  remediation: Store the base URL in a constant and set its value per environment, then reference the constant in the REST call or expression.
#  input: .*\$(Microflow|Nanoflow)\.yaml
package app.mendix.microflows.hardcoded_urls

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

url_pattern := `(?i)^https?://`

url_literal_pattern := `(?i)'https?://[^']+'`

expression_keys := {"Expression", "Value", "Argument", "ReturnValue", "DefaultValue", "InitialValue"}

errors contains error if {
	walk(input.ObjectCollection, [_, config])
	config["$Type"] == "Microflows$HttpConfiguration"
	url := location(config)
	regex.match(url_pattern, url)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' calls the hard-coded URL '%v'",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			url,
		],
	)
}

location(config) := config.CustomLocation if config.CustomLocation != ""

location(config) := config.CustomLocationTemplate.Text if object.get(config, "CustomLocation", "") == ""

errors contains error if {
	walk(input.ObjectCollection, [path, value])
	is_string(value)
	path[count(path) - 1] in expression_keys
	regex.match(url_literal_pattern, value)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' uses a hard-coded URL in an expression",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
