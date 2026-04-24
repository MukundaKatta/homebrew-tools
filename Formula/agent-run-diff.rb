class AgentRunDiff < Formula
  include Language::Python::Virtualenv

  desc "Compare baseline vs current agent runs; surface regressions as structured reasons"
  homepage "https://github.com/MukundaKatta/agent-run-diff"
  url "https://files.pythonhosted.org/packages/5a/8d/9e3d84f2059b17f5f7a4a8b63bec250b37a28b910eee52ddf9187a1f9ba8/agent_run_diff-0.1.0.tar.gz"
  sha256 "a1d3bcbcc1bdb8fafc3196c190c2e9b2e89b61e01abd54558adac4efa02388ff"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "agent-run-diff #{version}", shell_output("#{bin}/agent-run-diff --version")

    (testpath/"base.jsonl").write <<~EOS
      {"run_id":"r1","case_id":"c1","status":"success","final_output":"hello"}
    EOS
    (testpath/"curr.jsonl").write <<~EOS
      {"run_id":"r2","case_id":"c1","status":"failed","final_output":"error"}
    EOS
    out = shell_output("#{bin}/agent-run-diff #{testpath}/base.jsonl #{testpath}/curr.jsonl --format json", 1)
    assert_match "has_regressions", out
    assert_match "success_losses", out
  end
end
