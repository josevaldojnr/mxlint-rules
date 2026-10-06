# METADATA
# scope: package
# title: Too many parameters in microflow
# description: Microflows with many parameters are hard to call, hard to test and usually do more than one thing.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: TooManyParameters
#  severity: LOW
#  rulenumber: "005_0013"
#  remediation: Group related parameters in a (non-persistent) helper object or split the microflow into smaller microflows.
#  input: .*\$(Microflow|Nanoflow)\.yaml
package app.mendix.microflows.too_many_parameters

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

max_parameters := 5

parameter_types := {"Microflows$MicroflowParameter", "Microflows$NanoflowParameter"}

errors contains error if {
	parameters := [object |
		some object in input.ObjectCollection.Objects
		object["$Type"] in parameter_types
	]
	count(parameters) > max_parameters

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' has %v parameters which is more than %v",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			count(parameters),
			max_parameters,
		],
	)
}
