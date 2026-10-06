# METADATA
# scope: package
# title: External call without custom error handling
# description: REST and web service calls fail for reasons outside your control (timeouts, 4xx/5xx, DNS). With default error handling the whole transaction is rolled back or aborted and the user gets a generic error.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/error-handling-in-microflows/
# custom:
#  category: Error
#  rulename: IntegrationErrorHandling
#  severity: MEDIUM
#  rulenumber: "005_0008"
#  remediation: Set the error handling of the call to 'Custom' (with or without rollback), log the failure and return a meaningful result to the caller.
#  input: .*\$Microflow\.yaml
package app.mendix.microflows.integration_error_handling

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

external_call_types := {
	"Microflows$RestCallAction",
	"Microflows$WebServiceCallAction",
}

has_custom_error_handling(action) if startswith(lower(object.get(action, "ErrorHandlingType", "")), "custom")

errors contains error if {
	walk(input.ObjectCollection, [_, action])
	action["$Type"] in external_call_types
	not has_custom_error_handling(action)

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' has a %v without custom error handling",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			trim_prefix(action["$Type"], "Microflows$"),
		],
	)
}
