# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vipffoll/version'

Gem::Specification.new do |gem|
  gem.name          = "vipffoll"
  gem.version       = Vipffoll::VERSION
  gem.authors       = ["Tiago Justino"]
  gem.email         = ["tiago.vmj@gmail.com"]
  gem.description   = %q{A video player for training the skill of listening to foreign languages}
  gem.summary       = %q{Vipffoll (VIdeo Player For FOreign Language Learners) is a video player based on the website lyricstraining.com where you learn foreign languages having fun.}
  gem.homepage      = "github.com/tvmj02/vipffoll"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
