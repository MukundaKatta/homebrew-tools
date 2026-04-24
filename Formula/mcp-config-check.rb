class McpConfigCheck < Formula
  include Language::Python::Virtualenv

  desc "Linter for MCP config files (Claude Desktop, Cursor, Cline, Windsurf, Zed)"
  homepage "https://github.com/MukundaKatta/mcp-config-check"
  url "https://files.pythonhosted.org/packages/51/58/d0e5e98a0f44d7973464d4dbc6c038f15fc6fa55c878666694c5afa84cdf/mcp_config_check-0.1.0.tar.gz"
  sha256 "e8e92826f8f64e140dc142604ca43c75757972b2fcd24b10273dd17205fef9fa"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Version check
    assert_match "mcp-config-check #{version}", shell_output("#{bin}/mcp-config-check --version")

    # Valid MCP config should exit 0
    (testpath/"mcp.json").write <<~EOS
      {
        "mcpServers": {
          "fs": {
            "command": "node",
            "args": ["/abs/path/server.js"]
          }
        }
      }
    EOS
    system bin/"mcp-config-check", testpath/"mcp.json"
  end
end
