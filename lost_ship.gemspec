require_relative 'lib/lost_ship/version'

Gem::Specification.new do |spec|
  spec.name          = "lost_ship"
  spec.version       = LostShip::VERSION
  spec.authors       = ["Jeremy Friesen"]
  spec.email         = ["jeremy.n.friesen@gmail.com"]

  spec.summary       = %q{Emulator for "Lost Ship" by W.M. Akers}
  spec.description   = %q{Emulator for "Lost Ship" by W.M. Akers}
  spec.homepage      = "https://github.com/takeonrules/lost_ship"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "dry-schema", "~> 1.5"
  spec.add_dependency "dry-struct", "~> 1.0"
  spec.add_development_dependency "byebug"
end
