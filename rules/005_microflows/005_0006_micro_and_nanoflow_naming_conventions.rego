1. # METADATA
2. # scope: package
3. # title: Microflows and Nanoflows should follow Mendix naming conventions
4. # description: Ensure microflow and nanoflow names use Mendix naming conventions (PascalCase words, dot-separated module prefixes, no spaces or special characters).
5. # authors:
6. # - Copilot CLI <copilot@example.com>
7. # custom:
8. #  category: Naming
9. #  rulename: MicroAndNanoFlowNamingConventions
10. #  severity: MEDIUM
11. #  rulenumber: 005_0006
12. #  remediation: Rename microflows and nanoflows to use PascalCase words, optionally separated by dots for module prefixes. Avoid spaces and special characters other than underscores.
13. #  input: .*\$(Microflow|Nanoflow)\.yaml
14. package app.mendix.microflows.naming_conventions
15.
16. import rego.v1
17.
18. annotation := rego.metadata.chain()[1].annotations
19.
20. # Regex: start with uppercase letter, then letters/digits/underscores. Segments may be dot-separated (module prefixes).
21. name_regex := "^([A-Z][A-Za-z0-9_]*)(\\.([A-Z][A-Za-z0-9_]*))*$"
22.
23. default allow := false
24.
25. allow if count(errors) == 0
26.
27. errors contains error if {
28.     name := input.Name
29.     not re_match(name_regex, name)
30.     error := sprintf("[%v, %v, %v] Microflow/Nanoflow '%v' does not follow Mendix naming conventions; use PascalCase and optional dot-separated module prefixes without spaces or special characters.",
31.         [
32.             annotation.custom.severity,
33.             annotation.custom.category,
34.             annotation.custom.rulenumber,
35.             name,
36.         ]
37.     )
38. }
