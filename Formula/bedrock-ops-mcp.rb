class BedrockOpsMcp < Formula
  desc "MCP server: AWS Bedrock model intelligence and PII-safe response handling"
  homepage "https://github.com/MukundaKatta/bedrock-ops-mcp"
  url "https://registry.npmjs.org/@mukundakatta/bedrock-ops-mcp/-/bedrock-ops-mcp-0.1.0.tgz"
  sha256 "bfe0f183a6ae860fc7c08591b953f455ffc94863369f4225574d9382f11fdda0"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    require "open3"
    Open3.popen3("#{bin}/mcp-bedrock-ops") do |_stdin, _stdout, stderr, wait|
      ready_line = stderr.readline
      Process.kill("TERM", wait.pid)
      assert_match "bedrock-ops MCP server", ready_line
    end
  end
end
