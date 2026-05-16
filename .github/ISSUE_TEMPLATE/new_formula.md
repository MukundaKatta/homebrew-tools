---
name: New Formula proposal
about: Propose adding a new CLI tool to this tap.
title: "[new-formula] "
labels: enhancement
assignees: ''
---

## Scope check

This tap packages **CLI utilities maintained by @MukundaKatta**, currently focused on Claude Code / MCP linters, LLM observability tools, and small parsing utilities. New Formulas are accepted when:

- [ ] The tool is published on PyPI or npm with at least one tagged release.
- [ ] The tool is maintained by @MukundaKatta (or has a co-maintain arrangement).
- [ ] The tool has a stable public CLI surface (no `0.0.x` placeholders).
- [ ] There is a clear use case for installing it as a CLI via `brew install` (vs. just `pip install` / `npm install -g` in a venv).

If any of those are unchecked, the tool probably belongs in a different tap (or no tap at all).

## Proposed Formula

- Name: ...
- Upstream repo: https://github.com/...
- Latest release: v...
- Source registry: PyPI / npm
- Source artifact URL pattern: ...

## Why brew install instead of pip / npm install -g

What workflow does packaging this as a Homebrew Formula enable that `pip install` / `npm install -g` doesn't? (Common answer: keeps the tool out of the user's Python / Node ecosystem and managed by Homebrew alongside other CLIs.)

## Notes

If you're willing to draft the Formula yourself, please:

1. Read `CONTRIBUTING.md` > "Adding a new Formula" first.
2. For Python: run `brew create --python <upstream-sdist-url>` as a starting point.
3. For npm: model the install method after `Formula/streamparse.rb` (`std_npm_args` + `bin.install_symlink`).
4. Open the PR with the result.
