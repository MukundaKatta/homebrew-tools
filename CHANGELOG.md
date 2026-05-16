# Changelog

All notable changes to this Homebrew tap are documented here. Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

This file tracks **tap-level** changes (Formula bumps, new Formulas, CI / docs changes). For changes inside the packaged tools themselves, see the upstream repos linked from each Formula's `homepage`.

## [Unreleased]

Production-polish branch (this PR): adds `SECURITY.md` (with sha256-mismatch / tap-pinning / resource-drift surfaces called out), `CODE_OF_CONDUCT.md`, `CODEOWNERS` flagging `Formula/` for extra scrutiny, Dependabot config (GH Actions only, since taps have no language-ecosystem deps), issue + PR templates (new-Formula proposal + `brew install` repro shape), CI workflow that runs **`brew style` + `brew audit --strict` + `brew install --build-from-source` for every Formula on macOS 13 + 14** (catches sha256 drift, audit-rule regressions, and install-time breakage before merge), `CONTRIBUTING.md` with the documented "bump a Formula" procedure for both Python (resource blocks) and npm-backed Formulas. No Formula content changes.
