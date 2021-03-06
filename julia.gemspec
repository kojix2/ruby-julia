
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'julia/version'

Gem::Specification.new do |spec|
  spec.name          = "julia"
  version_components = [
    Julia::Version::MAJOR.to_s,
    Julia::Version::MINOR.to_s,
    Julia::Version::MICRO.to_s,
    Julia::Version::TAG,
  ]
  spec.version       = version_components.compact.join(".")
  spec.authors       = ["Kenta Murata"]
  spec.email         = ["mrkn@mrkn.jp"]

  spec.summary       = 'Julia on Ruby'
  spec.description   = 'Julia on Ruby'
  spec.homepage      = "https://github.com/mrkn/ruby-julia"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/julia/extconf.rb"]

  spec.add_development_dependency "bundler", ">= 1.17.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "test-unit"
end
