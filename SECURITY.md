# Security Policy

## Supported Versions

This is a Homebrew tap. Each Formula points at a specific release of an upstream package (Python sdist on PyPI, or a published npm tarball). Security fixes here mean updating a Formula to point at a fixed upstream release.

If an upstream package publishes a security fix, the corresponding Formula will be bumped within 7 days (faster for critical findings).

## Reporting a Vulnerability

Please **do not** open a public issue for security vulnerabilities.

Use [GitHub's private vulnerability reporting](https://github.com/MukundaKatta/homebrew-tools/security/advisories/new) on this repo, or email `mukunda.vjcs6@gmail.com` with subject `[homebrew-tools security]`. Include:

- Which Formula is affected (the file name under `Formula/`).
- A description of the vulnerability and its impact.
- Whether the issue is in the tap (Formula content) or upstream (the package being packaged).
- Reproduction steps.

You can expect:

- An acknowledgment within 5 business days.
- A status update within 14 days.
- A coordinated disclosure window of at most 90 days from the acknowledgment.

## Specific Risk Surfaces

A Homebrew tap is a small but real piece of supply-chain infrastructure. `brew install` runs Formula Ruby in a sandbox, downloads tarballs by URL, verifies them by sha256, then builds the artifact (a Python virtualenv, an npm-managed CLI, etc.). Areas worth special attention:

- **sha256 mismatch resolved the wrong way.** Every `url` field in a Formula MUST be paired with the correct sha256 of the exact tarball at that URL. If you find a Formula in this tap where the sha256 does not match the file currently served at the URL, that is a real issue. (Note: a transient mismatch during a bump-in-flight is not — `brew install` will refuse to install and surface the diff loudly. The concern is a Formula where the wrong sha256 is committed and `brew install` happily verifies a different file than intended.)
- **Tap-pinning attack via a fork.** If you find a PR or commit that retargets a Formula's `url` at a fork / non-upstream repo without a corresponding sha256 verification you can independently reproduce from the upstream maintainer's published artifact, please report.
- **Resource block drift (Python formulas).** Python formulas vendor their dep tree as `resource` blocks with individual sha256s. If any resource sha256 doesn't match what PyPI currently serves for that exact version, that's worth reporting.
- **`std_npm_args` drift (npm-backed formulas).** Formulas like `streamparse` and `streamparse-mcp` install from `registry.npmjs.org` tarballs. If the formula's sha256 doesn't match the npm-published tarball, that's a real issue — npm tarballs are content-addressed by registry, but a stale sha256 in a Formula could let a typosquatted package slip through.
- **Privilege escalation via install scripts.** The `install` method in each Formula must not `exec` or shell out to caller-controlled paths, and must not write outside the Homebrew prefix.
- **Lint-rule bypass for lint formulas.** Several Formulas in this tap are themselves linters (`claude-skill-check`, `mcp-config-check`, `claude-hooks-check`, `claude-commands-check`). Bugs **in those upstream linters** that miss a leaked-secret or dangerous-command pattern belong on the linter's own repo, not here. Bugs in the **packaging** that cause the linter to silently no-op are tap issues — please report.

## Out of scope

- **Upstream package vulnerabilities.** Bugs in the libraries / CLIs themselves should be reported on their respective upstream repos (this tap will bump the Formula once an upstream fix is published).
- **Homebrew core / `brew` itself.** Issues with the `brew` CLI go to <https://github.com/Homebrew/brew>.
- **Python / Node runtime behavior.** This tap doesn't ship Python or Node; it depends on `python@3.12` / `python@3.13` / `node` from Homebrew core.

## Bumping a Formula safely

See `CONTRIBUTING.md` for the documented procedure (regenerate sha256 from upstream's published artifact, paste both URLs into the PR description, run `brew audit --strict --new` locally, and have CI's `brew install --build-from-source` job pass on macOS before merge).

We will not pay bug bounties at this time.
