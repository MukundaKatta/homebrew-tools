class EmbspecMcp < Formula
  desc "MCP server: embedding pipeline ops + drift detection for production RAG"
  homepage "https://github.com/MukundaKatta/embspec-mcp"
  url "https://registry.npmjs.org/@mukundakatta/embspec-mcp/-/embspec-mcp-0.1.0.tgz"
  sha256 "cd4535a2740f1a15bc4a28bdd22a80ec86055494f643b987f316bc5c11811371"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    require "open3"
    Open3.popen3("#{bin}/mcp-embspec") do |_stdin, _stdout, stderr, wait|
      ready_line = stderr.readline
      Process.kill("TERM", wait.pid)
      assert_match "embspec MCP server", ready_line
    end
  end
end
