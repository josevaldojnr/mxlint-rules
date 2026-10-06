# METADATA
# scope: package
# title: Database credentials stored in project configuration
# description: A database password saved in Settings > Configurations is stored in the model and committed to version control. A real database (not the built-in HSQLDB) must not have its credentials in the project.
# authors:
# - Project Hygiene Contributor
# related_resources:
# - https://docs.mendix.com/refguide/configuration-tab/
# custom:
#  category: Security
#  rulename: DatabaseCredentialsInConfiguration
#  severity: HIGH
#  rulenumber: "006_0007"
#  remediation: Remove the database password from the project configuration and provide it through the runtime environment of each deployment. Rotate the exposed password.
#  input: .*Settings\$ProjectSettings\.yaml
package app.mendix.project_settings.database_credentials_in_configuration

import rego.v1

annotation := rego.metadata.chain()[1].annotations

default allow := false

allow if count(errors) == 0

errors contains error if {
	walk(input.Settings, [_, configuration])
	configuration["$Type"] == "Settings$ServerConfiguration"
	configuration.DatabaseType != "Hsqldb"
	trim_space(object.get(configuration, "DatabasePassword", "")) != ""

	error := sprintf(
		"[%v, %v, %v] A %v database password is stored in the project configuration '%v'",
		[
			annotation.custom.severity,
			annotation.custom.category,
			annotation.custom.rulenumber,
			configuration.DatabaseType,
			object.get(configuration, "Name", ""),
		],
	)
}
