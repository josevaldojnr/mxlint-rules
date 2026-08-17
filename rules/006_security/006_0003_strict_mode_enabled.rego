# METADATA
# scope: package
# title: Strict mode should be enabled
# description: Strict mode reduces the risk of insecure defaults and enforces stronger application security.
# authors:
# - Copilot
# custom:
#  category: Security
#  rulename: StrictModeEnabled
#  severity: MEDIUM
#  rulenumber: "006_0003"
#  remediation: Enable strict mode in Project Security.
#  input: Security$ProjectSecurity.yaml
package app.mendix.project_settings.strict_mode_enabled

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

errors contains error if {
    input.StrictMode == false
    error := sprintf("[%v, %v, %v] %v",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            "Strict mode is disabled in Project Security.",
        ]
    )
}
