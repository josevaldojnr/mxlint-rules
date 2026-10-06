# METADATA
# scope: package
# title: Sensitive constant has a default value
# description: The default value of a constant is stored in the model, so a password, key or token used as default is exposed to everyone with access to the source or a deployment package.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/constants/
# custom:
#  category: Security
#  rulename: SensitiveConstantDefaultValue
#  severity: HIGH
#  rulenumber: "006_0003"
#  remediation: Clear the default value and set the real value per environment (runtime configuration or environment variables). Rotate the exposed secret.
#  input: .*Constants\$Constant\.yaml
package app.mendix.constants.sensitive_constant_default_value

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

sensitive_name := `(?i)(password|passwd|pwd|secret|token|api[_-]?key|apikey|private[_-]?key|access[_-]?key|credential|encryption[_-]?key)`

errors contains error if {
	regex.match(sensitive_name, input.Name)
	trim_space(object.get(input, "DefaultValue", "")) != ""

	error := sprintf(
		"[%v, %v, %v] Constant '%v' looks sensitive but has a default value in the model",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
