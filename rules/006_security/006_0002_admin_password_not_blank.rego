# METADATA
# scope: package
# title: Admin password must not be blank
# description: Blank or default administrator credentials make the app easy to compromise.
# authors:
# - Copilot
# custom:
#  category: Security
#  rulename: AdminPasswordNotBlank
#  severity: HIGH
#  rulenumber: "006_0002"
#  remediation: Set a strong admin password and remove any default or empty credentials.
#  input: Security$ProjectSecurity.yaml
package app.mendix.project_settings.admin_password_not_blank

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

errors contains error if {
    input.AdminPassword == ""
    error := sprintf("[%v, %v, %v] %v",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            "Admin password is blank. Set a strong password in Project Security.",
        ]
    )
}
