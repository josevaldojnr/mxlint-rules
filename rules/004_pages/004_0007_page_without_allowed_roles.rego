# METADATA
# scope: package
# title: Page is not accessible to any module role
# description: A page without allowed module roles cannot be opened by any user. It is either dead code or a missing security configuration.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/page-properties/#allowed-roles
# custom:
#  category: Security
#  rulename: PageWithoutAllowedRoles
#  severity: MEDIUM
#  rulenumber: "004_0007"
#  remediation: Grant the page to the module roles that need it, or delete the page if it is no longer used.
#  input: .*\.Forms\$Page\.yaml
package app.mendix.pages.page_without_allowed_roles

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	count(object.get(input, "AllowedModuleRoles", [])) == 0

	error := sprintf(
		"[%v, %v, %v] Page '%v' is not accessible to any module role",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
