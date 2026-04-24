class LlmUsageReport < Formula
  include Language::Python::Virtualenv

  desc "Parse LLM API logs (Anthropic, OpenAI, Google) and produce token + cost reports"
  homepage "https://github.com/MukundaKatta/llm-usage-report"
  url "https://files.pythonhosted.org/packages/b9/53/4c082a4306d622cad18c8f8bb84d988becf7430cb26035aa9fcdac663e0e/llm_usage_report-0.1.0.tar.gz"
  sha256 "24df51c973f64bb63cb4482fb2faaf515fa085ddb95d23742b3dadc6eb56bc1c"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Version check
    assert_match "llm-usage-report #{version}", shell_output("#{bin}/llm-usage-report --version")

    # End-to-end: pipe one real API response line, expect cost + TOTAL in output
    (testpath/"usage.jsonl").write <<~EOS
      {"type":"message","model":"claude-sonnet-4-5","usage":{"input_tokens":1000,"output_tokens":500}}
    EOS
    out = shell_output("#{bin}/llm-usage-report #{testpath}/usage.jsonl")
    assert_match "claude-sonnet-4-5", out
    assert_match "TOTAL", out
  end
end
