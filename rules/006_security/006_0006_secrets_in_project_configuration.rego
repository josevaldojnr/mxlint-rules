# METADATA
# scope: package
# title: Secret value stored in project configuration
# description: Constant values configured in the project's Settings > Configurations are saved in the model. Secrets (keys, passwords, tokens) saved there are committed to version control with the project.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/configuration-tab/
# custom:
#  category: Security
#  rulename: SecretsInProjectConfiguration
#  severity: HIGH
#  rulenumber: "006_0006"
#  remediation: Remove the value from the project configuration and provide it per environment through the runtime (environment variable or deployment portal). Rotate the exposed secret.
#  input: .*Settings\$ProjectSettings\.yaml
package app.mendix.project_settings.secrets_in_project_configuration

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

sensitive_name := `(?i)(password|passwd|pwd|secret|token|api[_-]?key|apikey|private[_-]?key|access[_-]?key|credential|encryption[_-]?key)`

errors contains error if {
	walk(input.Settings, [_, constant_value])
	constant_value["$Type"] == "Settings$ConstantValue"
	regex.match(sensitive_name, constant_value.ConstantId)

	shared := constant_value.SharedOrPrivateValue
	shared["$Type"] == "Settings$SharedValue"
	trim_space(object.get(shared, "Value", "")) != ""

	error := sprintf(
		"[%v, %v, %v] Constant '%v' has a shared value in the project configuration",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			constant_value.ConstantId,
		],
	)
}
