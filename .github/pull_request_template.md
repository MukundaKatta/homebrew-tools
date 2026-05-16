<!--
Thanks for sending a PR to mukundakatta/homebrew-tools.

Quick reminders before you submit:
  - This is a tap. Every Formula change either bumps the SHA256 of a release tarball or restructures the install recipe.
  - The sha256 you commit MUST match the file at the URL you commit. CI will run `brew install --build-from-source` and catch a mismatch, but reviewers will also paste-check.
  - For Formula bumps, follow the procedure in CONTRIBUTING.md > "Bumping a Formula".
-->

## What this changes

A one-line summary, then a short paragraph if needed.

## Type of change

- [ ] Bump an existing Formula to a new upstream release
- [ ] Add a new Formula
- [ ] Fix a `brew audit` warning
- [ ] CI / docs / repo plumbing

## For a Formula bump

- [ ] The new `url` points at the upstream-published release artifact (GitHub release asset, PyPI sdist, or npm registry tarball — not a tag-archive).
- [ ] The new `sha256` was regenerated from the live URL: I ran `curl -fsSL <url> | shasum -a 256` and pasted the result below.
- [ ] For **Python** Formulas: all `resource` blocks were regenerated for the new upstream version (`brew update-python-resources <formula>` or by hand).
- [ ] For **npm-backed** Formulas: the new tarball is what `npm view <pkg>@<version> dist.tarball` returns.
- [ ] `brew audit --strict mukundakatta/tools/<formula>` passes locally.
- [ ] `brew install --build-from-source mukundakatta/tools/<formula>` succeeds locally.

```text
Old version: ...
New version: ...
Recomputed sha256: ...
```

## For a new Formula

- [ ] An issue was opened first ([new Formula proposal template](./ISSUE_TEMPLATE/new_formula.md)) and the scope check passed.
- [ ] For Python: uses `Language::Python::Virtualenv` and all deps are vendored as `resource` blocks with sha256s.
- [ ] For npm: uses `std_npm_args` and pins to a specific `registry.npmjs.org` tarball.
- [ ] `brew audit --strict --new mukundakatta/tools/<formula>` passes locally.
- [ ] `brew install --build-from-source mukundakatta/tools/<formula>` succeeds locally.

## Validation

- [ ] CI `brew style`, `brew audit`, and `brew install --build-from-source` jobs are green.

## Linked issue

Closes #
