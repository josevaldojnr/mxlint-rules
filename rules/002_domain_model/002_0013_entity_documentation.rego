# METADATA
# scope: package
# title: Persistent entity without documentation
# description: Persistent entities are the long-lived part of the data model. Undocumented entities make it hard for new team members to understand what a record represents.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: EntityDocumentation
#  severity: LOW
#  rulenumber: "002_0013"
#  remediation: Add a short description to the entity's Documentation property explaining what a record represents.
#  input: .*/DomainModels\$DomainModel\.yaml
package app.mendix.domain_model.entity_documentation

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

is_persistent(entity) if not entity.MaybeGeneralization.Persistable == false

errors contains error if {
	some entity in input.Entities
	is_persistent(entity)
	trim_space(object.get(entity, "Documentation", "")) == ""

	error := sprintf(
		"[%v, %v, %v] Entity '%v' has no documentation",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			entity.Name,
		],
	)
}
