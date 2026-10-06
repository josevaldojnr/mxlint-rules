# METADATA
# scope: package
# title: Attribute name not in PascalCase
# description: Entity attributes should use PascalCase. Attributes that exist purely for technical reasons (not business data) should start with an underscore, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: AttributeNamingConvention
#  severity: LOW
#  rulenumber: 002_0011
#  remediation: Rename the attribute to PascalCase (e.g. FirstName), or prefix with an underscore if it is a technical-only attribute (e.g. _InternalFlag).
#  input: .*/DomainModels\$DomainModel\.yaml
package app.mendix.domain_model.attribute_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^(_[A-Za-z0-9]+|[A-Z][A-Za-z0-9]*)$`

errors contains error if {
    not input.Entities == null
    entity := input.Entities[_]
    not entity.Attributes == null
    attribute := entity.Attributes[_]
    not regex.match(name_pattern, attribute.Name)
    error := sprintf("[%v, %v, %v] Attribute '%v' on entity '%v' is not PascalCase (or underscore-prefixed for technical attributes)",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            attribute.Name,
            entity.Name,
        ]
    )
}
