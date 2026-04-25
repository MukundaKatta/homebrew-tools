class StreamparseMcp < Formula
  desc "MCP server: parse partial / messy / truncated JSON for AI assistants"
  homepage "https://github.com/MukundaKatta/streamparse-mcp"
  url "https://registry.npmjs.org/@mukundakatta/streamparse-mcp/-/streamparse-mcp-1.0.0.tgz"
  sha256 "189180e8582cca5623b1eb8ae816ff930acbaedda1abfbb118fd40906cb90c47"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Spawn the server and verify it advertises ready on stderr.
    require "open3"
    Open3.popen3("#{bin}/mcp-streamparse") do |_stdin, _stdout, stderr, wait|
      ready_line = stderr.readline
      Process.kill("TERM", wait.pid)
      assert_match "streamparse MCP server", ready_line
    end
  end
end
