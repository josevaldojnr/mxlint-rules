# METADATA
# scope: package
# title: Password attribute must use the HashedString type
# description: Password attributes stored as plain strings expose credentials to anyone with database or backup access. The HashedString type stores only a hash.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/hashed-string-attribute-type/
# custom:
#  category: Security
#  rulename: PasswordAttributeNotHashed
#  severity: HIGH
#  rulenumber: "002_0014"
#  remediation: Change the attribute type to HashedString, or remove the attribute if it does not need to be persisted.
#  input: .*/DomainModels\$DomainModel\.yaml
package app.mendix.domain_model.password_attribute_not_hashed

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

password_pattern := `(?i)(password|passwd|passphrase|pwd)`

is_persistent(entity) if not entity.MaybeGeneralization.Persistable == false

is_calculated(attribute) if attribute.Value["$Type"] != "DomainModels$StoredValue"

errors contains error if {
	some entity in input.Entities
	is_persistent(entity)

	some attribute in entity.Attributes
	regex.match(password_pattern, attribute.Name)
	attribute.NewType["$Type"] == "DomainModels$StringAttributeType"
	not is_calculated(attribute)

	error := sprintf(
		"[%v, %v, %v] Attribute '%v.%v' looks like a password but is a plain string",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			entity.Name,
			attribute.Name,
		],
	)
}
