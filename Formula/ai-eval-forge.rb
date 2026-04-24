class AiEvalForge < Formula
  include Language::Python::Virtualenv

  desc "Zero-dependency eval harness for LLM and agent regression testing"
  homepage "https://github.com/MukundaKatta/ai-eval-forge"
  url "https://files.pythonhosted.org/packages/7e/a8/90b9f5e6302fef023647f0b1bfa8394fa9e7177a118904dbbf3f73bb08d0/ai_eval_forge-0.2.0.tar.gz"
  sha256 "04d44e6bc424e632a0f8e4b5ad32db4d37bd64ac7ffa24f4312de433406ebe1e"
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
