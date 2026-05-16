---
name: brew install failure
about: `brew install mukundakatta/tools/<formula>` failed. Not for upstream tool bugs (those go on the tool's own repo).
title: "[install] "
labels: bug
assignees: ''
---

## Which Formula

Paste the name (e.g. `claude-skill-check`, `mcp-config-check`, `llm-usage-report`, `streamparse`, etc.):

```
```

## Exact command

```bash
brew tap mukundakatta/tools
brew install mukundakatta/tools/<formula>
```

## Output

Please paste the **full output**, including the `brew config` block `brew` prints at the start of an error report. If `brew` told you to run `brew gist-logs <formula>`, paste the resulting gist URL.

```
```

## Environment

- macOS version: (`sw_vers`)
- Architecture: (`uname -m` — `arm64` for Apple Silicon, `x86_64` for Intel)
- Homebrew version: (`brew --version`)
- For Python-backed Formulas: (`brew --version python@3.12` and `brew --version python@3.13`)
- For npm-backed Formulas: (`brew --version node`)
- Have you tried `brew update && brew tap --repair` and reproduced? (yes / no)

## sha256 sanity check

For the failing Formula, please confirm the committed sha256 matches what's served right now (this rules out a one-day-stale-tarball or `--HEAD` confusion):

```bash
# Get the committed url + sha256
brew cat mukundakatta/tools/<formula> | grep -E '^\s+(url|sha256) "' | head -2

# Recompute sha256 from the live URL
curl -fsSL <url-from-above> | shasum -a 256
```

Are they the same? (yes / no — if no, this is a security report and belongs on the private advisory form instead)

## Notes

Anything else — whether the build failed in a specific resource (which one), whether you've successfully installed an earlier version of the same Formula, anything else suspicious.
