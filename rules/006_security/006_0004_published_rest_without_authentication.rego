# METADATA
# scope: package
# title: Published REST service without authentication
# description: A published REST service that does not require authentication can be called by anyone who can reach the application.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/published-rest-service/#authentication
# custom:
#  category: Security
#  rulename: PublishedRestWithoutAuthentication
#  severity: HIGH
#  rulenumber: "006_0004"
#  remediation: Configure at least one authentication method (for example Basic, Active session or Custom microflow) on the published REST service.
#  input: .*Rest\$PublishedRestService\.yaml
package app.mendix.rest.published_rest_without_authentication

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	count(object.get(input, "AuthenticationTypes", [])) == 0

	error := sprintf(
		"[%v, %v, %v] Published REST service '%v' does not require authentication",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
