class AgentBudget < Formula
  include Language::Python::Virtualenv

  desc "Production retry/budget primitive for LLM and agent calls"
  homepage "https://github.com/MukundaKatta/agent-budget"
  url "https://github.com/MukundaKatta/agent-budget/releases/download/v0.1.0/agent_budget-0.1.0.tar.gz"
  sha256 "c6a97a5fd35d71bc06f3bef5aa5f313b279914a9f450dd04dee39042b369e78c"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    script = <<~PYTHON
      from agent_budget import budget, AdversarialLoopDetected, AttemptEvent
      assert budget.__name__
    PYTHON
    system libexec/"bin/python", "-c", script
  end
end
