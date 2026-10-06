# METADATA
# scope: package
# title: Microflow must use a standard event prefix
# description: Every microflow name must start with a standard Mendix event prefix followed by PascalCase. This validates the naming format; it cannot verify the prefix matches the microflow's actual trigger since that requires cross-referencing other documents.
# authors:
# - Naming Convention Contributor
# custom:
#  category: Maintainability
#  rulename: MicroflowPrefixConvention
#  severity: LOW
#  rulenumber: 005_0007
#  remediation: Use one of the standard Mendix microflow prefixes (e.g. ACO_, BCO_, ACR_, BCR_, ADE_, BDE_, ARO_, BRO_, CAL_, OEN_, OCH_, OLE_, DS_, ACT_, WFA_, WFS_, WFC_, VAL_, SCE_, SUB_, TEST_, UT_, CWS_, CRS_, PWS_, PRS_, POS_, ASU_, BSD_, HCH_) followed by PascalCase, e.g. ACT_Vendor_StartWorkflow.
#  input: .*\$Microflow\.yaml
package app.mendix.microflows.microflow_prefix_convention
import rego.v1
annotation := rego.metadata.chain()[1].annotations

default allow := false
allow if count(errors) == 0

valid_prefixes := {
	"ACO", "BCO", "ACR", "BCR", "ADE", "BDE", "ARO", "BRO",
	"CAL", "OEN", "OCH", "OLE", "DS", "ACT",
	"WFA", "WFS", "WFC", "VAL", "SCE", "SUB",
	"TEST", "UT", "CWS", "CRS", "PWS", "PRS", "POS",
	"ASU", "BSD", "HCH",
}

prefix_pattern := `^([A-Z]{2,4})_(.*)$`
remainder_pattern := `^[A-Z][A-Za-z0-9]*(_[A-Z][A-Za-z0-9]*)*$`

has_standard_prefix if {
	some prefix in valid_prefixes
	startswith(input.Name, sprintf("%v_", [prefix]))
}

errors contains error if {
	not has_standard_prefix
	not regex.match(prefix_pattern, input.Name)
	error := sprintf("[%v, %v, %v] Microflow '%v' does not start with a standard Mendix event prefix",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
		]
	)
}

errors contains error if {
	matches := regex.find_all_string_submatch_n(prefix_pattern, input.Name, 1)
	count(matches) > 0
	prefix := matches[0][1]
	not prefix in valid_prefixes
	error := sprintf("[%v, %v, %v] Microflow '%v' uses nonstandard prefix '%v_' which is not one of the standard Mendix event prefixes",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			prefix,
		]
	)
}

errors contains error if {
	matches := regex.find_all_string_submatch_n(prefix_pattern, input.Name, 1)
	count(matches) > 0
	prefix := matches[0][1]
	prefix in valid_prefixes
	remainder := matches[0][2]
	not regex.match(remainder_pattern, remainder)
	error := sprintf("[%v, %v, %v] Microflow '%v' has standard prefix '%v_' but the remainder '%v' is not PascalCase",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			input.Name,
			prefix,
			remainder,
		]
	)
}
