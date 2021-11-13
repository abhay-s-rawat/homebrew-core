class PySpy < Formula
  desc "Sampling profiler for Python programs"
  homepage "https://github.com/benfred/py-spy"
  url "https://github.com/benfred/py-spy/archive/refs/tags/v0.3.11.tar.gz"
  sha256 "094cfb80e2c099763453fc39cfa9c46cfa423afa858268c6a7bc0d867763b014"
  license "MIT"
  head "https://github.com/benfred/py-spy.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9fb10ad2b7b0ba0cb1feb0d2ba187adda91ef6685409a9277cbea32cfedf46ff"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8e7e23078fb6f4cc9e1549dc33030b56a3213d747fb15f2cae7a7a9175db6083"
    sha256 cellar: :any_skip_relocation, monterey:       "2c5191ce53ca249d91bc5daefd410e0dd35ddda1a470a4079fcae1002168cb91"
    sha256 cellar: :any_skip_relocation, big_sur:        "73a98156d4dafa6614709c52ed51e47652fde038348fed6da03b43c40b9935d5"
    sha256 cellar: :any_skip_relocation, catalina:       "dae2729dc5a12091d77f7192e920c21659a05973d1af6a72aaa5bf36b607ceeb"
    sha256 cellar: :any_skip_relocation, mojave:         "f6cc40bca3872cd5bb2afa27d62eb6d676b9dc03678deff3f1da1dde31deaf6b"
  end

  depends_on "rust" => :build
  depends_on "python@3.9" => :test

  def install
    system "cargo", "install", *std_cargo_args

    bash_output = Utils.safe_popen_read(bin/"py-spy", "completions", "bash")
    (bash_completion/"py-spy").write bash_output
    zsh_output = Utils.safe_popen_read(bin/"py-spy", "completions", "zsh")
    (zsh_completion/"_py-spy").write zsh_output
    fish_output = Utils.safe_popen_read(bin/"py-spy", "completions", "fish")
    (fish_completion/"py-spy.fish").write fish_output
  end

  test do
    output = shell_output("#{bin}/py-spy record python3.9 2>&1", 1)
    assert_match "This program requires root", output
  end
end
