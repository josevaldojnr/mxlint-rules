# METADATA
# scope: package
# title: Avoid unlimited string attributes on persistent entities
# description: Unlimited strings (length 0) are stored as large text columns, cannot be indexed efficiently and make it easy to store unbounded input.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/string-attribute-type/
# custom:
#  category: Performance
#  rulename: AvoidUnlimitedStringLength
#  severity: LOW
#  rulenumber: "002_0012"
#  remediation: Set an explicit maximum length on the string attribute. Keep unlimited only for genuinely free-form content such as documents or payloads.
#  input: .*/DomainModels\$DomainModel\.yaml
package app.mendix.domain_model.avoid_unlimited_string_length

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

is_persistent(entity) if not entity.MaybeGeneralization.Persistable == false

is_calculated(attribute) if attribute.Value["$Type"] != "DomainModels$StoredValue"

errors contains error if {
	some entity in input.Entities
	is_persistent(entity)

	some attribute in entity.Attributes
	attribute.NewType["$Type"] == "DomainModels$StringAttributeType"
	attribute.NewType.Length == 0
	not is_calculated(attribute)

	error := sprintf(
		"[%v, %v, %v] Attribute '%v.%v' is an unlimited string",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			entity.Name,
			attribute.Name,
		],
	)
}
