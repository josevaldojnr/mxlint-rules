# METADATA
# scope: package
# title: Strict page URL checks should be enabled
# description: Disabling strict page URL checks can enable URL tampering and bypasses.
# authors:
# - Copilot
# custom:
#  category: Security
#  rulename: StrictPageUrlCheckEnabled
#  severity: MEDIUM
#  rulenumber: "006_0004"
#  remediation: Enable strict page URL checking in Project Security.
#  input: Security$ProjectSecurity.yaml
package app.mendix.project_settings.strict_page_url_check

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

errors contains error if {
    input.StrictPageUrlCheck == false
    error := sprintf("[%v, %v, %v] %v",
        [
            annotation.custom.severity,
            annotation.custom.category,
            annotation.custom.rulenumber,
            "Strict page URL check is disabled in Project Security.",
        ]
    )
}
