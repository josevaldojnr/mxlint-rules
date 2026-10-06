# METADATA
# scope: package
# title: Scheduled event name missing SCE_ prefix
# description: Scheduled events run unattended and should be easy to recognize in logs and in the runtime's scheduled event overview.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/dev-best-practices/#naming-conventions
# custom:
#  category: Maintainability
#  rulename: ScheduledEventNamingConvention
#  severity: LOW
#  rulenumber: "007_0005"
#  remediation: Rename the scheduled event to use the SCE_ prefix followed by PascalCase, e.g. SCE_CleanupExpiredSessions.
#  input: .*ScheduledEvents\$ScheduledEvent\.yaml
package app.mendix.naming_conventions.scheduled_event_naming_convention

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

name_pattern := `^SCE_[A-Z][A-Za-z0-9]*(_[A-Z][A-Za-z0-9]*)*$`

errors contains error if {
	not regex.match(name_pattern, input.Name)

	error := sprintf(
		"[%v, %v, %v] Scheduled event '%v' does not follow the SCE_{Name} naming convention",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
