# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spiderwasp/version'

Gem::Specification.new do |spec|
  spec.name          = "spiderwasp"
  spec.version       = Spiderwasp::VERSION
  spec.authors       = ["Aleksey Ivanov"]
  spec.email         = ["mov.stox@gmail.com"]

  spec.summary       = %q{A gem to collect data for Spiderwasp.co service}
  spec.description   = %q{Enables advanced logging and blocking unwanted crawlers.}
  spec.homepage      = "https://spiderwasp.co"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3.1'

  spec.add_dependency "rack-attack", "~> 5.0.1"
  spec.add_dependency 'redis', '>= 3.3.5', '< 5'
  spec.add_dependency 'connection_pool', '~> 2.2', '>= 2.2.2'
  spec.add_development_dependency "rack-attack", "~> 5.0.1"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
