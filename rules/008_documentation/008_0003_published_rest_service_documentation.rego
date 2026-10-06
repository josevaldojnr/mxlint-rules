# METADATA
# scope: package
# title: Published REST service without documentation
# description: Published REST services are consumed by other teams and systems. Documentation tells consumers (and future maintainers) what the service is for and who owns it.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: PublishedRestServiceDocumentation
#  severity: LOW
#  rulenumber: "008_0003"
#  remediation: Add documentation to the published REST service describing its purpose, consumers and owner.
#  input: .*Rest\$PublishedRestService\.yaml
package app.mendix.documentation.published_rest_service_documentation

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	trim_space(object.get(input, "Documentation", "")) == ""

	error := sprintf(
		"[%v, %v, %v] Published REST service '%v' has no documentation",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
