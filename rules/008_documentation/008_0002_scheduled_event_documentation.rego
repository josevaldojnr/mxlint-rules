# METADATA
# scope: package
# title: Scheduled event without documentation
# description: Scheduled events run unattended, often at night. Documentation should say what the event does, how often it runs and what to do when it fails.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: ScheduledEventDocumentation
#  severity: LOW
#  rulenumber: "008_0002"
#  remediation: Add documentation to the scheduled event describing its purpose, schedule and failure handling.
#  input: .*ScheduledEvents\$ScheduledEvent\.yaml
package app.mendix.documentation.scheduled_event_documentation

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	trim_space(object.get(input, "Documentation", "")) == ""

	error := sprintf(
		"[%v, %v, %v] Scheduled event '%v' has no documentation",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
