# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.1] - 2024-04-09

### Fixed

- Objects can be compared to `nil` with `==`.

## [1.1.0] - 2024-01-25

### Added

- Objects can be compared with `==`.

## [1.0.5] - 2023-07-10

### Added

- Properties can be set (setters).

## [1.0.4] - 2023-04-06

### Fixed

- Properties can be prefixed when serialized.

## [1.0.3] - 2023-02-20

### Fixed

- SemanticId and SemanticType are properly setted during object initialization.
- SemanticId is the first exported property.

## [1.0.2] - 2023-02-13

### Changed

- Do not export empty collection properties.

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

[unreleased]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.5...v1.1.0
[1.0.5]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/assemblee-virtuelle/semantizer-ruby/compare/v1.0.0-alpha...v1.0.0
[1.0.0-alpha]: https://github.com/assemblee-virtuelle/semantizer-ruby/releases/tag/v1.0.0-alpha
