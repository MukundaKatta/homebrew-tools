# Contributing to mukundakatta/homebrew-tools

This is a small, single-maintainer Homebrew tap. It packages CLI utilities maintained by @MukundaKatta — Claude Code / MCP linters, LLM observability tools, and small parsing utilities — as `brew install`-able Formulas.

## In scope

- Bumping an existing Formula to a new upstream release.
- Fixing `brew audit --strict` warnings on an existing Formula.
- Adding a new Formula that fits the scope check (see `.github/ISSUE_TEMPLATE/new_formula.md`).
- CI / docs / repo hygiene improvements.

## Out of scope

- **Upstream tool changes.** Bugs in the packaged CLIs themselves (linter logic, llm-usage-report parsing, streamparse semantics, etc.) belong on their own repos. Each Formula's `homepage` line points at the right place.
- **Third-party CLIs.** This tap stays focused on @MukundaKatta-maintained tools.
- **Bottle hosting.** Bottles (pre-built binaries) require a GHCR / S3 host. We ship source Formulas only; `brew install` builds from the upstream sdist / npm tarball.

## Local setup

```bash
git clone https://github.com/MukundaKatta/homebrew-tools.git
cd homebrew-tools

# Symlink this checkout as the tap so `brew` resolves to your local edits.
mkdir -p "$(brew --repository)/Library/Taps/mukundakatta"
ln -sf "$PWD" "$(brew --repository)/Library/Taps/mukundakatta/homebrew-tools"
```

After that, `brew install mukundakatta/tools/<formula>` uses your local checkout.

## Bumping a Formula

When upstream publishes a new release, follow this procedure.

### Python-backed Formulas

(e.g. `llm-usage-report`, `ai-eval-forge`, `agent-run-diff`, `claude-skill-check`, `mcp-config-check`, `claude-hooks-check`, `claude-commands-check`)

1. **Find the new upstream artifact.** Prefer the **PyPI sdist** (`.tar.gz`) at `https://files.pythonhosted.org/...`, or the GitHub release tarball. Avoid the auto-generated git tag archive — it can drift if the upstream maintainer force-pushes a tag.

   ```bash
   FORMULA=llm-usage-report
   NEW_VERSION=0.1.2
   ```

2. **Compute the new sha256 from the live URL.** Do NOT trust whatever sha256 a chat assistant suggests; recompute it.

   ```bash
   NEW_URL="https://files.pythonhosted.org/.../${FORMULA//-/_}-$NEW_VERSION.tar.gz"
   curl -fsSL "$NEW_URL" | shasum -a 256
   ```

3. **Regenerate the `resource` blocks** for the new version:

   ```bash
   brew update-python-resources "mukundakatta/tools/$FORMULA"
   ```

   Sanity-check the diff — every changed `url` should be paired with a matching changed `sha256`.

4. **Run the local quality gates** before pushing:

   ```bash
   brew style --tap mukundakatta/tools
   brew audit --strict "mukundakatta/tools/$FORMULA"
   brew install --build-from-source "mukundakatta/tools/$FORMULA"
   ```

### npm-backed Formulas

(e.g. `streamparse`, `streamparse-mcp`)

1. **Find the new upstream artifact.** npm-published Formulas use the registry tarball:

   ```bash
   FORMULA=streamparse
   NEW_VERSION=1.0.2

   NEW_URL=$(npm view "@mukundakatta/$FORMULA@$NEW_VERSION" dist.tarball)
   echo "$NEW_URL"
   ```

2. **Compute the new sha256:**

   ```bash
   curl -fsSL "$NEW_URL" | shasum -a 256
   ```

3. **Edit the Formula** to update `url` and `sha256`. There are no Python `resource` blocks to regenerate for npm-backed Formulas (npm handles its own dep tree at install time via `std_npm_args`).

4. **Run the local quality gates:**

   ```bash
   brew style --tap mukundakatta/tools
   brew audit --strict "mukundakatta/tools/$FORMULA"
   brew install --build-from-source "mukundakatta/tools/$FORMULA"
   ```

### After the bump (both flavors)

5. **Open a PR.** Use the PR template. Paste the recomputed sha256 into the description so reviewers can verify against the upstream artifact independently.

6. **Wait for CI.** The `brew install --build-from-source` job on macOS-13 and macOS-14 is the real gate; it will refuse to install if a committed sha256 doesn't match the live URL.

## Adding a new Formula

1. Open an issue first using the [new Formula proposal template](.github/ISSUE_TEMPLATE/new_formula.md).
2. Wait for a scope-check yes/no.
3. Generate a starter Formula:
   - For Python: `brew create --python <upstream-sdist-url>`
   - For npm: model the install method after `Formula/streamparse.rb`.
4. Move it under `Formula/<name>.rb`, regenerate resources (for Python), run local quality gates (style, audit, install).
5. **Add the new Formula to `.github/workflows/ci.yml`** under the `install.strategy.matrix.formula` list, in the same PR. (The matrix is currently static; CI won't test a Formula that isn't listed.)
6. Open the PR.

## Coding conventions

- Formulas live under `Formula/<name>.rb`.
- Python Formulas use `Language::Python::Virtualenv` and pin `depends_on "python@3.12"` or `python@3.13` as appropriate.
- npm-backed Formulas use `std_npm_args` and `bin.install_symlink Dir["#{libexec}/bin/*"]`.
- License must match upstream; don't relicense the package on its way through the tap.
- Keep the `desc` line tight (under 80 chars) and aligned with the upstream README's tagline.

## What CI checks

See `.github/workflows/ci.yml`. Every PR runs:

- `brew style` (Ruby style for Formulas)
- `brew audit --strict` (every Formula, individually)
- `brew install --build-from-source` (every Formula on macOS-13 and macOS-14, independently — so a single Formula breaking doesn't block reviewing the others)
- A post-install sanity check that the install prefix exists and (best-effort) that the installed binary responds to `--help` / `-h`.

CI must be green before review.
