# METADATA
# scope: package
# title: Strict page URL check must be enabled
# description: When the strict page URL check is disabled, a user can open a page by guessing its URL, even when the page is not reachable through the navigation or the user's roles.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/project-security/
# custom:
#  category: Security
#  rulename: StrictPageUrlCheck
#  severity: MEDIUM
#  rulenumber: "001_0010"
#  remediation: Enable 'Strict page URL check' in Project Security.
#  input: .*Security\$ProjectSecurity\.yaml
package app.mendix.project_settings.strict_page_url_check

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	input.StrictPageUrlCheck == false

	error := sprintf(
		"[%v, %v, %v] %v",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			annotation.title,
		],
	)
}
