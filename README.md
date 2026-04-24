# homebrew-tools

A [Homebrew](https://brew.sh) tap with my CLI utilities. Right now it ships four linters for Claude Code and MCP configuration, packaged as self-contained Homebrew formulae so you don't need to manage a Python environment yourself.

## Tap it

```bash
brew tap mukundakatta/tools
```

## Available formulae

| Formula | What it does |
|---|---|
| `claude-skill-check` | Lint Claude Code `SKILL.md` files (YAML frontmatter, required fields, description length, leaked secrets). |
| `mcp-config-check` | Lint MCP (Model Context Protocol) config files for Claude Desktop, Cursor, Cline, Windsurf, Zed. |
| `claude-hooks-check` | Lint the `hooks` block of a Claude Code `settings.json` (typos, dangerous commands, leaked secrets). |
| `claude-commands-check` | Lint Claude Code slash-command files in `.claude/commands/`. |
| `llm-usage-report` | Parse LLM API response logs (Anthropic, OpenAI, Google) and generate token + cost reports. |
| `ai-eval-forge` | Zero-dependency eval harness for LLM and agent regression testing. Scores outputs with exact, contains, regex, token-F1, JSON, and citation checks. |
| `agent-run-diff` | Compare baseline vs current agent runs; surface regressions as structured reasons across 7 signals (success loss, new errors, tool failures, output drift, step/latency/cost bloat). |

## Install one (or more)

```bash
brew install claude-skill-check
brew install mcp-config-check
brew install claude-hooks-check
brew install claude-commands-check
```

Or install all four at once:

```bash
brew install claude-skill-check mcp-config-check claude-hooks-check claude-commands-check
```

## Use

Each formula installs a CLI of the same name:

```bash
claude-skill-check path/to/SKILL.md
mcp-config-check ~/Library/Application\ Support/Claude/claude_desktop_config.json
claude-hooks-check ~/.claude/settings.json
claude-commands-check .claude/commands/
```

Exit status is `0` on no errors and `1` on any errors, so the CLIs compose cleanly in git hooks and CI.

## Source and upstream releases

Each formula pulls its sdist from PyPI. The upstream repos are:

- [claude-skill-check](https://github.com/MukundaKatta/claude-skill-check) — also on [PyPI](https://pypi.org/project/claude-skill-check/)
- [mcp-config-check](https://github.com/MukundaKatta/mcp-config-check) — also on [PyPI](https://pypi.org/project/mcp-config-check/)
- [claude-hooks-check](https://github.com/MukundaKatta/claude-hooks-check) — also on [PyPI](https://pypi.org/project/claude-hooks-check/)
- [claude-commands-check](https://github.com/MukundaKatta/claude-commands-check) — also on [PyPI](https://pypi.org/project/claude-commands-check/)

## Updating

```bash
brew update
brew upgrade claude-skill-check   # or any of the others
```

## Uninstall the tap

```bash
brew untap mukundakatta/tools
```

## License

Each formula carries the upstream project's license (MIT across all four). This tap itself is MIT-licensed.
