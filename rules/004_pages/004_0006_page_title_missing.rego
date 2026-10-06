# METADATA
# scope: package
# title: Page has no title
# description: A page without a title gives screen reader users and browser tabs no context about where they are.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/page-properties/
# custom:
#  category: Accessibility
#  rulename: PageTitleMissing
#  severity: LOW
#  rulenumber: "004_0006"
#  remediation: Set a descriptive Title in the page properties.
#  input: .*\.Forms\$Page\.yaml
package app.mendix.pages.page_title_missing

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

has_title if {
	some item in input.Title.Items
	trim_space(object.get(item, "Text", "")) != ""
}

errors contains error if {
	not has_title

	error := sprintf(
		"[%v, %v, %v] Page '%v' has no title",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		],
	)
}
