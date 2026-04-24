class ClaudeSkillCheck < Formula
  include Language::Python::Virtualenv

  desc "Linter for Claude Code SKILL.md files"
  homepage "https://github.com/MukundaKatta/claude-skill-check"
  url "https://files.pythonhosted.org/packages/7d/0d/022cb92bcc37d765feeab05483cb23e46628d08c2bebbddbbe0e65f119b8/claude_skill_check-0.1.0.tar.gz"
  sha256 "87452792787c8cec86260e64b1657dd1c2a2ca290cc460b6509364d77595ab1f"
  license "MIT"

  depends_on "libyaml"
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
    assert_match "claude-skill-check #{version}", shell_output("#{bin}/claude-skill-check --version")

    # Valid SKILL.md should exit 0
    (testpath/"SKILL.md").write <<~EOS
      ---
      name: demo-skill
      description: A demo skill used to smoke-test the Homebrew formula for claude-skill-check.
      ---

      # Demo

      Body here.
    EOS
    system bin/"claude-skill-check", testpath/"SKILL.md"
  end
end
