# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'month_constrain/version'

Gem::Specification.new do |spec|
  spec.name          = "month_constrain"
  spec.version       = MonthConstrain::VERSION
  spec.authors       = ["yusaku.hatanaka"]
  spec.email         = ["yusaku.hatanaka@speee.jp"]

  spec.summary       = "month_constrain is a re-implementation of acts_as_month_constrain for Rails 4, and 5."
  spec.description   = "month_constrain is a re-implementation of acts_as_month_constrain for Rails 4, and 5."
  spec.homepage      = "https://github.com/speee/month-constrain"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 4.2.3'
  spec.add_dependency 'activerecord', '>= 4.0'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.43"
  spec.add_development_dependency "sqlite3", "~> 1.0"
end
