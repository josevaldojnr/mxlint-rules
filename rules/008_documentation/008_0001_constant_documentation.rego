# METADATA
# scope: package
# title: Constant without documentation
# description: Constants hold environment-specific configuration. Without documentation, nobody knows what value is expected, where it comes from, or whether it is safe to change.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: ConstantDocumentation
#  severity: LOW
#  rulenumber: "008_0001"
#  remediation: Describe in the constant's Documentation what it configures, the expected format, and where the value is managed.
#  input: .*Constants\$Constant\.yaml
package app.mendix.documentation.constant_documentation

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	trim_space(object.get(input, "Documentation", "")) == ""

	error := sprintf(
		"[%v, %v, %v] Constant '%v' has no documentation",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
