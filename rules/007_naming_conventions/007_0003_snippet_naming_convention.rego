# METADATA
# scope: package
# title: Snippet name missing SNIP_ prefix
# description: Snippets should be identified with the SNIP_ prefix, per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: SnippetNamingConvention
#  severity: LOW
#  rulenumber: 007_0003
#  remediation: Rename the snippet to use the SNIP_ prefix, e.g. SNIP_CustomerHeader.
#  input: .*\.Forms\$Snippet\.yaml
package app.mendix.naming_conventions.snippet_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

name_pattern := `^SNIP_[A-Z][A-Za-z0-9]*$`

errors contains error if {
    not regex.match(name_pattern, input.Name)
    error := sprintf("[%v, %v, %v] Snippet '%v' does not follow the SNIP_{Name} naming convention",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            input.Name,
        ]
    )
}
