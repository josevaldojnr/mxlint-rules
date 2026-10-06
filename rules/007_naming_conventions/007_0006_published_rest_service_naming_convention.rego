# METADATA
# scope: package
# title: Published REST service name missing PRS_ prefix
# description: Published REST services are part of the application's public contract. A consistent prefix makes them easy to find and review.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/dev-best-practices/#naming-conventions
# custom:
#  category: Maintainability
#  rulename: PublishedRestServiceNamingConvention
#  severity: LOW
#  rulenumber: "007_0006"
#  remediation: Rename the published REST service to use the PRS_ prefix followed by PascalCase, e.g. PRS_Orders.
#  input: .*Rest\$PublishedRestService\.yaml
package app.mendix.naming_conventions.published_rest_service_naming_convention

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

name_pattern := `^PRS_[A-Z][A-Za-z0-9]*(_[A-Z][A-Za-z0-9]*)*$`

errors contains error if {
	not regex.match(name_pattern, input.Name)

	error := sprintf(
		"[%v, %v, %v] Published REST service '%v' does not follow the PRS_{Name} naming convention",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
