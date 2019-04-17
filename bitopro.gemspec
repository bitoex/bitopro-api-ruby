
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "./lib/bitopro/version"

Gem::Specification.new do |spec|
  spec.name          = "bitopro"
  spec.version       = Bitopro::VERSION
  spec.authors       = ["niclin"]
  spec.email         = ["bboyceo@hotmail.com"]

  spec.files         = ['lib/bitopro.rb', *Dir.glob('lib/**/*')]
  spec.test_files   = Dir.glob('spec/**/*')

  spec.summary       = "bitopro-#{Bitopro::VERSION}"
  spec.description   = %q{Ruby wrapper for the Bitopro API.}
  spec.homepage      = "https://github.com/niclin/bitopro"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "webmock", '~> 3.0'

  spec.add_dependency 'rest-client'
end
