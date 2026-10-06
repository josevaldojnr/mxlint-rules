# METADATA
# scope: package
# title: Layout name missing standard device/purpose prefix
# description: Layouts should be identified with a standard prefix indicating their target device or purpose (Responsive_, Tablet_, Phone_, NativePhone_, Popup_, Atlas_), per Mendix naming convention best practices.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: LayoutNamingConvention
#  severity: LOW
#  rulenumber: 007_0002
#  remediation: Rename the layout to start with one of the standard prefixes, e.g. Responsive_Main.
#  input: .*Layouts\$Layout\.yaml
package app.mendix.naming_conventions.layout_naming_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

valid_prefixes := ["Responsive_", "Tablet_", "Phone_", "NativePhone_", "Popup_", "Atlas_"]

any_prefix_matches if {
    some prefix in valid_prefixes
    startswith(input.Name, prefix)
}

errors contains error if {
    not any_prefix_matches
    error := sprintf("[%v, %v, %v] Layout '%v' does not start with a standard prefix (%v)",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            input.Name,
            concat(", ", valid_prefixes),
        ]
    )
}
