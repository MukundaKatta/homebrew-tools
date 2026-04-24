class ClaudeCommandsCheck < Formula
  include Language::Python::Virtualenv

  desc "Linter for Claude Code slash-command files (.claude/commands/*.md)"
  homepage "https://github.com/MukundaKatta/claude-commands-check"
  url "https://files.pythonhosted.org/packages/4f/76/9cd6c226e325d29c832523b8bb7f770ddc408f28e147cb5985f4f3549b7a/claude_commands_check-0.1.0.tar.gz"
  sha256 "2b7b67a73aaf9b1ff5ff9940a1607d6ed79eb585d97852ac0950a7c005d44dae"
  license "MIT"

  depends_on "python@3.12"

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Version check
    assert_match "claude-commands-check #{version}", shell_output("#{bin}/claude-commands-check --version")

    # Valid slash-command file should exit 0
    (testpath/"my-cmd.md").write <<~EOS
      ---
      description: A demo slash command used to smoke-test the Homebrew formula.
      ---

      Please do the thing.
    EOS
    system bin/"claude-commands-check", testpath/"my-cmd.md"
  end
end
