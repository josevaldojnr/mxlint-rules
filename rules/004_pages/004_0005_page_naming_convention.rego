# METADATA
# scope: package
# title: Page name not in PascalCase or has an incorrectly cased suffix
# description: Page names should use PascalCase. If a page name uses one of the standard Mendix suffixes (_Overview, _New, _Edit, _NewEdit, _View, _Select, _MultiSelect, _Tooltip, _Workflow) it must match the exact casing, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: PageNamingConvention
#  severity: LOW
#  rulenumber: 004_0005
#  remediation: Rename the page to PascalCase, optionally followed by one of the standard suffixes, e.g. Customer_Overview.
#  input: .*\.Forms\$Page\.yaml
package app.mendix.pages.page_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^[A-Z][A-Za-z0-9]*(_(Overview|New|Edit|NewEdit|View|Select|MultiSelect|Tooltip|Workflow))?$`

errors contains error if {
    not regex.match(name_pattern, input.Name)
    error := sprintf("[%v, %v, %v] Page '%v' is not PascalCase or has an incorrectly cased/unrecognized suffix",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            input.Name,
        ]
    )
}
