# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
  * Pull Request Template
  * Updated ex_doc to latest version (0.27.2)
  * Added new `--open` flag that calls into the `IEx.Helpers.open/1` function for opening the source code in your editor

### Fixed
  * Allow erlang modules.function/airity i.e `:ets.new/2`

## [0.1.2] - 2022-01-09
### Added
  * Support for erlang documentation (if erlang is compiled with docs)
  * Support for color

### Documentation
  * Added Changelog, License and Readme to hex docs

## [0.1.1] - 2022-01-05
### Added
Initial Release to Hex

[Unreleased]: https://github.com/silbermm/exdoc_cli/compare/v0.1.2...HEAD
[0.1.2]: https://github.com/silbermm/exdoc_cli/releases/tag/v0.1.2
[0.1.1]: https://github.com/silbermm/exdoc_cli/releases/tag/v0.1.1
