# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'picturepath_aui/version'

Gem::Specification.new do |spec|
  spec.name          = "picturepath_aui"
  spec.version       = PicturepathAUI::VERSION
  spec.authors       = ["Antonio Antillon"]
  spec.email         = ["antillas21@gmail.com"]

  spec.summary       = %q{A ruby wrapper around the PicturePath AUI API.}
  spec.description   = %q{A ruby wrapper around the PicturePath AUI API. PicturePath provides an API to post virtual tours to Realtor.com and other real estate websites.}
  spec.homepage      = "https://github.com/antillas21/picturepath_aui"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency "nori"
  spec.add_dependency "rubysl-rexml"
end
