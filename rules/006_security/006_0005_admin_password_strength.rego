# METADATA
# scope: package
# title: Admin password is weaker than the password policy
# description: The administrator account has the highest privileges. Its password stored in the project must satisfy at least the project's own password policy (and never be shorter than 8 characters).
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/project-security/
# custom:
#  category: Security
#  rulename: AdminPasswordStrength
#  severity: HIGH
#  rulenumber: "006_0005"
#  remediation: Set a longer admin password that satisfies the password policy (length, digit, mixed case, symbol), and change it in every deployed environment.
#  input: .*Security\$ProjectSecurity\.yaml
package app.mendix.project_settings.admin_password_strength

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

minimum_length := max([8, object.get(input, ["PasswordPolicySettings", "MinimumLength"], 8)])

errors contains error if {
	password := object.get(input, "AdminPassword", "")
	password != ""
	count(password) < minimum_length

	error := sprintf(
		"[%v, %v, %v] Admin password is shorter than %v characters",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			minimum_length,
		],
	)
}

errors contains error if {
	password := object.get(input, "AdminPassword", "")
	password != ""
	object.get(input, ["PasswordPolicySettings", "RequireDigit"], false) == true
	not regex.match(`[0-9]`, password)

	error := sprintf(
		"[%v, %v, %v] Admin password does not contain a digit as required by the password policy",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
		],
	)
}

errors contains error if {
	password := object.get(input, "AdminPassword", "")
	password != ""
	object.get(input, ["PasswordPolicySettings", "RequireMixedCase"], false) == true
	not mixed_case(password)

	error := sprintf(
		"[%v, %v, %v] Admin password does not contain upper and lower case letters as required by the password policy",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
		],
	)
}

errors contains error if {
	password := object.get(input, "AdminPassword", "")
	password != ""
	object.get(input, ["PasswordPolicySettings", "RequireSymbol"], false) == true
	not regex.match(`[^A-Za-z0-9]`, password)

	error := sprintf(
		"[%v, %v, %v] Admin password does not contain a symbol as required by the password policy",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
		],
	)
}

mixed_case(password) if {
	regex.match(`[a-z]`, password)
	regex.match(`[A-Z]`, password)
}
