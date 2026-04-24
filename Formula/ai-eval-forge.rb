class AiEvalForge < Formula
  include Language::Python::Virtualenv

  desc "Zero-dependency eval harness for LLM and agent regression testing"
  homepage "https://github.com/MukundaKatta/ai-eval-forge"
  url "https://files.pythonhosted.org/packages/0c/92/38f393fcadd01b3d1610fdedd31b22b6eb11d35f8392228d3e3d05dc142b/ai_eval_forge-0.1.0.tar.gz"
  sha256 "ce4fa62d0f19f8f47e9613f1d97f0330a3dc9ec7b9ddaf078a32f7463d4182d6"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Both the short and long CLI names should resolve to v0.1.0
    assert_match "ai-eval-forge #{version}", shell_output("#{bin}/ai-eval-forge --version")
    assert_match "ai-eval-forge #{version}", shell_output("#{bin}/aef --version")

    (testpath/"cases.jsonl").write <<~EOS
      {"id":"c1","actual":"hello world","expected":"hello world"}
    EOS
    out = shell_output("#{bin}/aef score #{testpath}/cases.jsonl")
    assert_match "\"passed\": 1", out
    assert_match "\"failed\": 0", out
  end
end
