<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
<span align="center">
  
  [![Contributors][contributors-shield]][contributors-url]
  [![Forks][forks-shield]][forks-url]
  [![Issues][issues-shield]][issues-url]
  [![Unlicense License][license-shield]][license-url]

</span>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/mxlint">
    <img src="https://avatars.githubusercontent.com/u/180859514?s=200&v=4" alt="Logo" width="160">
  </a>

  <h3 align="center">MxLint - Rules</h3>

  <p align="center">
    The repository of rules that come out-of-the-box rules with the MxLint CLI and Mendix Studio Pro extension
    <br />
    <a href="https://mxlint.com/"><strong>MxLint website »</strong></a>
    <br />
    <br />
    <a href="https://mxlint.com/assets/videos/mxlint-extension-2024-09-12-responsive.mp4" target="_blank">View Demo</a>
    &middot;
    <a href="https://github.com/mxlint/mxlint-rules/issues/new" target="_blank">Report an issue</a>
    &middot;
    <a href="https://github.com/mxlint/mxlint-rules/issues/new" target="_blank">Request feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- GETTING STARTED -->
## Getting started
Add new rules to your Mendix project by downloading the applicable `.rego` file and storing it in the project's `.mendix-cache/rules` folder. This folder contains subfolders for each rule category.

Each rule comes with its own `_test` file, which contains test data and one or more test cases.

For more information, see the installation instructions on the [MxLint website](https://mxlint.com/mendix-studio-pro-extension/installation/).


## Rules
All rules in this repository. Most have a `_test.yaml` (or `_test.rego`) next to them; 001_0007, 001_0008, 005_0001, 005_0003, 005_0004, 005_0005 and 006_0002 do not have a `_test.yaml` yet. Marketplace modules are excluded by the export (`export.appstore: false`), so rules only apply to your own modules.

| Rule | Severity | What it checks |
|------|----------|----------------|
| 001_0001 | HIGH | Anonymous (guest) access is disabled |
| 001_0002 | HIGH | Demo users are disabled |
| 001_0003 | HIGH | Security checks are active |
| 001_0004 | HIGH | Strong password policy |
| 001_0005 | HIGH | Admin user id is not `MxAdmin` |
| 001_0007 | HIGH | Hash algorithm is BCrypt or SSHA256 |
| 001_0008 | HIGH | Security is checked on every user role |
| 001_0009 | HIGH | Strict mode is enabled when using the React client |
| 001_0010 | MEDIUM | Strict page URL check is enabled |
| 002_0001 | MEDIUM | At most 15 persistent entities per domain model |
| 002_0002 | MEDIUM | At most 35 attributes per entity |
| 002_0003 | MEDIUM | Do not inherit from Administration.Account |
| 002_0004 | MEDIUM | Avoid inheriting from non-System modules |
| 002_0005 | HIGH | Avoid associations to System entities |
| 002_0006 | MEDIUM | Avoid too many calculated (microflow) attributes |
| 002_0007 | MEDIUM | Avoid validation rules in the domain model |
| 002_0008 | MEDIUM | Avoid default ReadWrite access rules |
| 002_0009 | LOW | No default values on attributes |
| 002_0010 | LOW | Entity names are PascalCase |
| 002_0011 | LOW | Attribute names are PascalCase |
| 002_0012 | LOW | No unlimited string attributes on persistent entities |
| 002_0013 | LOW | Persistent entities are documented |
| 002_0014 | HIGH | Password attributes use HashedString |
| 003_0001 | MEDIUM | At most 20 modules in the project |
| 003_0002 | LOW | Module names are PascalCase |
| 004_0001 | MEDIUM | No inline style property on pages/snippets |
| 004_0002 | MEDIUM | Images have alt text |
| 004_0003 | HIGH | Only one h1 per page |
| 004_0004 | HIGH | Headings are in ascending order |
| 004_0005 | LOW | Page naming convention |
| 004_0006 | LOW | Pages have a title |
| 004_0007 | MEDIUM | Pages are accessible to at least one module role |
| 005_0001 | MEDIUM | Empty string checks are complete |
| 005_0002 | MEDIUM | No commits inside loops |
| 005_0003 | MEDIUM | At most 25 elements per microflow |
| 005_0004 | MEDIUM | Complex microflows have annotations |
| 005_0005 | MEDIUM | No nested if-statements in split expressions |
| 005_0007 | LOW | Microflow names use a standard event prefix |
| 005_0008 | MEDIUM | REST/web service calls have custom error handling |
| 005_0009 | HIGH | No hard-coded secrets in microflows/nanoflows |
| 005_0010 | MEDIUM | No hard-coded URLs in microflows/nanoflows |
| 005_0011 | LOW | No disabled activities left in flows |
| 005_0012 | MEDIUM | No unconstrained "retrieve all" from the database |
| 005_0013 | LOW | At most 5 parameters per flow |
| 006_0001 | HIGH | Constants with sensitive data are not exposed to the client |
| 006_0002 | HIGH | Admin password is not blank |
| 006_0003 | HIGH | Sensitive constants have no default value |
| 006_0004 | HIGH | Published REST services require authentication |
| 006_0005 | HIGH | Admin password satisfies the password policy |
| 006_0006 | HIGH | No secrets in the project's shared configuration values |
| 006_0007 | HIGH | No database credentials in the project configuration |
| 007_0001 | LOW | Enumeration names use `ENUM_` |
| 007_0002 | LOW | Layout names use a standard prefix |
| 007_0003 | LOW | Snippet names use `SNIP_` |
| 007_0004 | LOW | Nanoflow naming convention |
| 007_0005 | LOW | Scheduled event naming convention (`SCE_`) |
| 007_0006 | LOW | Published REST service naming convention (`PRS_`) |
| 008_0001 | LOW | Constants are documented |
| 008_0002 | LOW | Scheduled events are documented |
| 008_0003 | LOW | Published REST services are documented |

To accept a finding for one document (for example an OAuth callback service that is intentionally unauthenticated), add `#noqa:006_0004 reason` to that document's documentation.

<!-- ROADMAP -->
## Roadmap

- [x] Add README
- [ ] Add changelog
- [ ] Convert all [Mendix Best Practices for Development](https://docs.mendix.com/refguide/dev-best-practices/) to rules


<!-- CONTRIBUTING -->
## Contributing
MxLint and its rules is a fully open source project, driven entirely by the Mendix community! That is why we welcome any and all contributions!

If you want to contribute, this is the way:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

You pull request will be reviewed and, if accepted, merged into the mainline of MxLint.


<!-- LICENSE -->
## License
MxLint&mdash;the CLI tools, the Mendix Studio Pro extension and its rules&mdash;is distributed under the [AGPL license](https://github.com/mxlint/mxlint-rules/blob/main/LICENSE)


<!-- CONTACT -->
## Contact
Xiwen Cheng - [LinkedIn](https://linkedin.com/in/xiwen) - [Email](mailto:x@cinaq.com)

Bart Zantingh - [LinkedIn](https://linkedin.com/in/bartzantingh) - [Email](mailto:bart.zantingh@nl.abnamro.com)

MxLint project home: [https://github.com/mxlint](https://github.com/mxlint)

## Useful links
- [MxLint home](https://mxlint.com/)
- [Open Policy Agent home](https://www.openpolicyagent.org/)
- [Open Policy Agent docs](https://www.openpolicyagent.org/docs/latest/)
- [Rego language reference](https://www.openpolicyagent.org/docs/latest/policy-reference/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/mxlint/mxlint-rules?style=for-the-badge&logo=data:image/svg+xml;base64,PCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KDTwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIFRyYW5zZm9ybWVkIGJ5OiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT4KPHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBmaWxsPSJub25lIj4KDTxnIGlkPSJTVkdSZXBvX2JnQ2FycmllciIgc3Ryb2tlLXdpZHRoPSIwIi8+Cg08ZyBpZD0iU1ZHUmVwb190cmFjZXJDYXJyaWVyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KDTxnIGlkPSJTVkdSZXBvX2ljb25DYXJyaWVyIj4gPGcgZmlsbD0iI2ZmZiI+IDxwYXRoIGQ9Ik0zLjQ2MiA3Ljk0MmE1LjYzOCA1LjYzOCAwIDAxMS4yMTYtMi4yOTljLS4xODctLjE0Ny0uOTI4LS43NTUtLjk2My0xLjIzMkMzLjY2MSAzLjYyOSA0LjQwMyAxIDQuNDAzIDFzLTIuMjQgMi44NzYtMi4zOTUgNC4wMzlDMS44ODQgNS45NSAzLjMgNy43NiAzLjQ0OSA3Ljk0NXYtLjAwM2guMDEzem05LjExNC0uMDQ3VjcuOWMwIC4wMDQuMDAzLjAwNy4wMDMuMDEuMjQ4LS4zMTQgMS41My0yIDEuNDEzLTIuODcyQzEzLjgzOCAzLjg3NiAxMS41OTggMSAxMS41OTggMXMuNzQyIDIuNjI5LjY4OCAzLjQxYy0uMDMyLjQ1OC0uNzA3IDEuMDMtLjkzMiAxLjIxYTUuNTcgNS41NyAwIDAxMS4yMjMgMi4yNzV6Ii8+IDxwYXRoIGQ9Ik0xMi41NzYgNy44OTh2LS4wMDZhNS42MTUgNS42MTUgMCAwMC0xLjIyMy0yLjI3NWMtLjg3LS45Ny0yLjA1Ni0xLjU1LTMuMzMzLTEuNTV2My4xMDZoLjAwNGMuMzEzLjAwNC41NjcuMjc0LjU2Ny42MDUgMCAuMDQtLjAwMy4wNzctLjAxLjExNGEuNTgzLjU4MyAwIDAxLS41NTcuNDloLS4wMXYxLjE1M2wtLjAwNiA1LjQ1OGguMTFzMS4yMDUtMS44MzcgMS44NTQtMi4zNjFjLjc2LS42MTUgMi42MDQtMS4zNzcgMi42MDQtMS4zNzd2LTMuMzJsLjAxLS4wMDNjLS4wMDQtLjAwNy0uMDA0LS4wMTctLjAwNy0uMDI0IDAtLjAwMyAwLS4wMDYtLjAwMy0uMDF6Ii8+IDxwYXRoIGQ9Ik04LjAxNCA5LjUzOFY4LjM4NmEuNTguNTggMCAwMS0uNTQ4LS40NDQuNjUuNjUgMCAwMS0uMDIyLS4xNmMwLS4zMzUuMjU3LS42MDUuNTczLS42MDVoLjAwNFY0LjA4Yy0xLjI4NCAwLTIuNDcyLjU4NS0zLjM0MyAxLjU2M2E1LjYxNiA1LjYxNiAwIDAwLTEuMjE2IDIuMjk5aC0uMDF2My4zNjRzMS44NDQuNzYxIDIuNjA0IDEuMzc2Yy42My41MSAxLjg0NyAyLjMxOCAxLjg0NyAyLjMxOGguMTE0di0uMDAzaC0uMDA2bC4wMDMtNS40NTl6Ii8+IDwvZz4gPC9nPgoNPC9zdmc+
[contributors-url]: https://github.com/mxlint/mxlint-rules/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/mxlint/mxlint-rules?style=for-the-badge&logo=git&logoColor=white
[forks-url]: https://github.com/mxlint/mxlint-rules/network
[issues-shield]: https://img.shields.io/github/issues/mxlint/mxlint-rules?style=for-the-badge
[issues-url]: https://github.com/mxlint/mxlint-rules/issues
[license-shield]: https://img.shields.io/badge/License-AGPL-663066?style=for-the-badge&logo=gnu
[license-url]: https://github.com/mxlint/mxlint-rules/blob/main/LICENSE
