# METADATA
# scope: package
# title: Hard-coded secret in microflow
# description: Credentials, tokens and keys written into microflow expressions end up in version control, in every deployed model and in every developer's workspace.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/constants/
# custom:
#  category: Security
#  rulename: HardcodedSecrets
#  severity: HIGH
#  rulenumber: "005_0009"
#  remediation: Move the secret to a constant that is not exposed to the client and set its value per environment (or use a secrets store). Rotate the exposed secret.
#  input: .*\$(Microflow|Nanoflow)\.yaml
package app.mendix.microflows.hardcoded_secrets

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

secret_name := `(?i)(password|passwd|pwd|secret|token|api[_-]?key|apikey|private[_-]?key|access[_-]?key|credential)`

# Secrets embedded in a string value, keyed by a description of what was detected.
secret_patterns := {
	"credential assignment": `(?i)(password|passwd|pwd|secret|api[_-]?key|apikey|access[_-]?key|client[_-]?secret|access[_-]?token)=[^&\s'"{]{4,}`,
	"credentials in URL": `(?i)[a-z][a-z0-9+.-]*://[^/\s:@'"]+:[^/\s@'"]+@`,
	"bearer or basic token": `(?i)\b(bearer|basic)\s+[A-Za-z0-9\-_.=+/]{16,}`,
	"AWS access key": `\bAKIA[0-9A-Z]{16}\b`,
	"private key": `-----BEGIN [A-Z ]*PRIVATE KEY-----`,
}

# A non-trivial string literal written directly in an expression, e.g. 'abc123'.
is_string_literal(value) if regex.match(`^'[^']{3,}'$`, value)

ignored_keys := {"Documentation", "Caption"}

errors contains error if {
	walk(input.ObjectCollection, [path, value])
	is_string(value)
	not path[count(path) - 1] in ignored_keys
	some description, pattern in secret_patterns
	regex.match(pattern, value)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' contains a hard-coded secret (%v)",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			description,
		],
	)
}

errors contains error if {
	walk(input.ObjectCollection, [_, header])
	header["$Type"] == "Microflows$HttpHeaderEntry"
	regex.match(`(?i)^(authorization|x-api-key|api[-_]?key|.*secret.*|.*token.*|.*password.*)$`, header.Key)
	is_string_literal(header.Value)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' sets the HTTP header '%v' to a hard-coded value",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			header.Key,
		],
	)
}

errors contains error if {
	walk(input.ObjectCollection, [_, config])
	config["$Type"] == "Microflows$HttpConfiguration"
	config.UseHttpAuthentication == true
	is_string_literal(config.HttpAuthenticationPassword)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' uses a hard-coded HTTP authentication password",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}

errors contains error if {
	walk(input.ObjectCollection, [_, item])
	item["$Type"] == "Microflows$ChangeActionItem"
	regex.match(secret_name, item.Attribute)
	is_string_literal(item.Value)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' sets the secret attribute '%v' to a hard-coded value",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			item.Attribute,
		],
	)
}
