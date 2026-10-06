# METADATA
# scope: package
# title: Nanoflow must use a standard prefix
# description: Nanoflow names should start with a standard Mendix prefix followed by PascalCase, so their purpose is clear from the name.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/dev-best-practices/#naming-conventions
# custom:
#  category: Maintainability
#  rulename: NanoflowNamingConvention
#  severity: LOW
#  rulenumber: "007_0004"
#  remediation: Rename the nanoflow to use one of the prefixes ACT_, DS_, VAL_, NAV_, OCH_, OEN_, OLE_, CAL_, SUB_, TEST_ or UT_, followed by PascalCase, e.g. ACT_Customer_Save.
#  input: .*\$Nanoflow\.yaml
package app.mendix.naming_conventions.nanoflow_naming_convention

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

name_pattern := `^(ACT|DS|VAL|NAV|OCH|OEN|OLE|CAL|SUB|TEST|UT)_[A-Z][A-Za-z0-9]*(_[A-Z][A-Za-z0-9]*)*$`

errors contains error if {
	not regex.match(name_pattern, input.Name)

	error := sprintf(
		"[%v, %v, %v] Nanoflow '%v' does not follow the {Prefix}_{Name} naming convention",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
