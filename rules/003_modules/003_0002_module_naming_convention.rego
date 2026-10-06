# METADATA
# scope: package
# title: Module name not in PascalCase
# description: Module names should use PascalCase (UpperCamelCase) and identify the module's responsibility, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: ModuleNamingConvention
#  severity: LOW
#  rulenumber: 003_0002
#  remediation: Rename the module to PascalCase, e.g. CustomerManagement.
#  input: .*Metadata\.yaml
package app.mendix.modules.module_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^[A-Z][A-Za-z0-9]*$`

errors contains error if {
    not input.Modules == null
    some i
    input.Modules[i].Attributes.FromAppStore == false
    module_name := input.Modules[i].Name
    not regex.match(name_pattern, module_name)
    error := sprintf("[%v, %v, %v] Module '%v' is not PascalCase",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            module_name,
        ]
    )
}
