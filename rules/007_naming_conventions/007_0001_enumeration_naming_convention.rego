# METADATA
# scope: package
# title: Enumeration name missing ENUM_ prefix
# description: Enumeration names should be identified with the ENUM_ prefix followed by PascalCase, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: EnumerationNamingConvention
#  severity: LOW
#  rulenumber: 007_0001
#  remediation: Rename the enumeration to use the ENUM_ prefix, e.g. ENUM_ShippingStatus.
#  input: .*Enumerations\$Enumeration\.yaml
package app.mendix.naming_conventions.enumeration_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^ENUM_[A-Z][A-Za-z0-9]*$`

errors contains error if {
    not regex.match(name_pattern, input.Name)
    error := sprintf("[%v, %v, %v] Enumeration '%v' does not follow the ENUM_{Name} naming convention",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            input.Name,
        ]
    )
}
