# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{colormath}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Battley"]
  s.date = %q{2009-09-09}
  s.email = %q{pbattley@gmail.com}
  s.files = ["README.md", "test/blend_test.rb", "test/conversion_test.rb", "test/hex_decoding_test.rb", "test/hsl_test.rb", "test/rgb_test.rb", "lib/colormath", "lib/colormath/blend.rb", "lib/colormath/color", "lib/colormath/color/hsl.rb", "lib/colormath/color/rgb.rb", "lib/colormath/color.rb", "lib/colormath/version.rb", "lib/colormath.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Colour manipulation library for Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end
