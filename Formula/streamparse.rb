class Streamparse < Formula
  desc "Streaming JSON parser that yields partial valid trees as tokens arrive"
  homepage "https://github.com/MukundaKatta/streamparse"
  url "https://registry.npmjs.org/@mukundakatta/streamparse/-/streamparse-1.0.1.tgz"
  # Update on publish: shasum -a 256 streamparse-1.0.1.tgz
  sha256 "REPLACE_AFTER_NPM_PUBLISH"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Version check
    assert_match "streamparse #{version}", shell_output("#{bin}/streamparse --version")

    # parse partial JSON
    output = pipe_output("#{bin}/streamparse parse -", '{"name":"Cl', 0)
    assert_match "\"Cl\"", output

    # validate strict JSON, exit 0 on valid
    pipe_output("#{bin}/streamparse validate -", '{"a":1}', 0)

    # validate strict JSON, exit 1 on trailing comma
    pipe_output("#{bin}/streamparse validate -", '{"a":1,}', 1)
  end
end
