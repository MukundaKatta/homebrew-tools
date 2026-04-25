class StreamparseMcp < Formula
  desc "MCP server: parse partial / messy / truncated JSON for AI assistants"
  homepage "https://github.com/MukundaKatta/streamparse-mcp"
  url "https://registry.npmjs.org/@mukundakatta/streamparse-mcp/-/streamparse-mcp-1.0.1.tgz"
  sha256 "9723640f711176da472b2de4e435e0d032a2871a5f0bd97ea57ed0f7657eaaa6"
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
