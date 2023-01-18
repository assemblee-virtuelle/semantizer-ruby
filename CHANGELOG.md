# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

None.

## [1.0.1] - 2023-01-18

### Fixed

- Add a runtime dependency to `json-ld`.

## [1.0.0] - 2023-01-12

### Added

- .gitignore file.
- Changelog file.

### Changed

- The classes are now accessed through the `VirtualAssembly::Semantizer` module (instead of just the `Semantizer` module).
- The `SemanticObject` is now a module instead of a class.

## [1.0.0-alpha] - 2023-01-05

### Added

- SemanticObject, SemanticProperty and HashSerializer classes.
- License and readme files.
- Gemspec file.

[unreleased]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.0...HEAD
[1.0.1]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.0-alpha...v1.0.0
[1.0.0-alpha]: https://github.com/assemblee-virtuelle/semantizer-ruby/releases/tag/v1.0.0-alpha
