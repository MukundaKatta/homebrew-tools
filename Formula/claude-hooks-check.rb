class ClaudeHooksCheck < Formula
  include Language::Python::Virtualenv

  desc "Linter for Claude Code hooks configuration"
  homepage "https://github.com/MukundaKatta/claude-hooks-check"
  url "https://files.pythonhosted.org/packages/1c/83/0a49d745d890795ecfbd5c84e956a59515cf1a90365afc6edcaa44bf1e2b/claude_hooks_check-0.1.0.tar.gz"
  sha256 "980851b8ebc7d9539239a1d61ea3c3a31cd065090eeca81409c61b67ade7a467"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Version check
    assert_match "claude-hooks-check #{version}", shell_output("#{bin}/claude-hooks-check --version")

    # Valid hooks config should exit 0
    (testpath/"settings.json").write <<~EOS
      {
        "hooks": {
          "PreToolUse": [
            {
              "matcher": "Bash",
              "hooks": [
                {"type": "command", "command": "echo hi"}
              ]
            }
          ]
        }
      }
    EOS
    system bin/"claude-hooks-check", testpath/"settings.json"
  end
end
