class LlmUsageReport < Formula
  include Language::Python::Virtualenv

  desc "Parse LLM API logs (Anthropic, OpenAI, Google) and produce token + cost reports"
  homepage "https://github.com/MukundaKatta/llm-usage-report"
  url "https://files.pythonhosted.org/packages/7c/9f/049f82564602abb71e5cbd725f3d993c2e79a76b1db99341961e9a267675/llm_usage_report-0.1.1.tar.gz"
  sha256 "37a7647f89456be5cc0593bc88d914520618184a1383979ca745d9c05fe15de4"
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
