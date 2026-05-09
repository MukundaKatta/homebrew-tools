class Embspec < Formula
  include Language::Python::Virtualenv

  desc "Embedding pipeline ops + drift detection for production RAG"
  homepage "https://github.com/MukundaKatta/embspec"
  url "https://github.com/MukundaKatta/embspec/releases/download/v0.1.0/embspec-0.1.0.tar.gz"
  sha256 "f03d8f05d9cc4e7db508380aa2453cea034a2f6d5970dfccabc343c09fac5ea5"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "python@3.13"

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/d7/9f/b8cef5bffa569759033adda9481211426f12f53299629b410340795c2514/numpy-2.4.4.tar.gz"
    sha256 "2d390634c5182175533585cc89f3608a4682ccb173cc9bb940b2881c8d6f8fa0"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    script = <<~PYTHON
      from embspec import IndexManifest, DriftAdapter, neighbor_stability
      r = neighbor_stability({"q": ["a", "b", "c"]}, {"q": ["a", "b", "c"]}, k=3)
      assert r.mean_overlap_at_k == 1.0
    PYTHON
    system libexec/"bin/python", "-c", script
  end
end
