# METADATA
# scope: package
# title: Retrieve of all objects from the database without a constraint
# description: Retrieving a list with no XPath constraint and no limit loads the whole table into memory. It works with test data and fails with production volumes.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/retrieve/
# custom:
#  category: Performance
#  rulename: RetrieveAllWithoutConstraint
#  severity: MEDIUM
#  rulenumber: "005_0012"
#  remediation: Add an XPath constraint, or retrieve a custom range (limit and offset) and process the data in batches. Ignore this finding only for small, bounded configuration entities.
#  input: .*\$(Microflow|Nanoflow)\.yaml
package app.mendix.microflows.retrieve_all_without_constraint

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	walk(input.ObjectCollection, [_, action])
	action["$Type"] == "Microflows$RetrieveAction"

	source := action.RetrieveSource
	source["$Type"] == "Microflows$DatabaseRetrieveSource"
	source.Range["$Type"] == "Microflows$ConstantRange"
	object.get(source.Range, "SingleObject", false) == false
	trim_space(object.get(source, "XpathConstraint", "")) == ""

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' retrieves all '%v' objects without a constraint",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			source.Entity,
		],
	)
}
