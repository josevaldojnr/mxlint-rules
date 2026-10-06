# METADATA
# scope: package
# title: Entity name not in PascalCase
# description: Entity names should use PascalCase and avoid underscores, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: EntityNamingConvention
#  severity: LOW
#  rulenumber: 002_0010
#  remediation: Rename the entity to PascalCase without underscores, e.g. HousekeepingRecord.
#  input: .*/DomainModels\$DomainModel\.yaml
package app.mendix.domain_model.entity_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^[A-Z][A-Za-z0-9]*$`

errors contains error if {
    not input.Entities == null
    entity := input.Entities[_]
    not regex.match(name_pattern, entity.Name)
    error := sprintf("[%v, %v, %v] Entity '%v' is not PascalCase",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            entity.Name,
        ]
    )
}
