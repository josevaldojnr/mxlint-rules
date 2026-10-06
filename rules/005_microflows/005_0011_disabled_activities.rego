# METADATA
# scope: package
# title: Disabled activity left in microflow
# description: Disabled activities are dead code. They clutter the microflow, confuse reviewers and are easily re-enabled by accident.
# authors:
# - Project Hygiene Contributor
# custom:
#  category: Maintainability
#  rulename: DisabledActivities
#  severity: LOW
#  rulenumber: "005_0011"
#  remediation: Delete the disabled activity. Version control keeps the history if it is needed again.
#  input: .*\$(Microflow|Nanoflow)\.yaml
package app.mendix.microflows.disabled_activities

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	walk(input.ObjectCollection, [_, activity])
	activity["$Type"] == "Microflows$ActionActivity"
	activity.Disabled == true

	error := sprintf(
		"[%v, %v, %v] Microflow '%v' contains a disabled activity '%v'",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			object.get(activity, "Caption", ""),
		],
	)
}
