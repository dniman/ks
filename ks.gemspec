
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ks/version"

Gem::Specification.new do |spec|
  spec.name          = "ks"
  spec.version       = KS::VERSION
  spec.authors       = ["dniman"]
  spec.email         = ["dade.niman@gmail.com"]

  spec.summary       = "ks utility"
  spec.description   = "Migration generator, source code managment utility for ks projects"
  spec.homepage      = "https://github.com/dniman/ks"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = ""

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 3.1.0"
  spec.add_development_dependency "aruba", "~> 0.14.5"

  spec.add_dependency "thor", '~> 0.20.0'
end
