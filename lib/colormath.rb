module ColorMath
  ParsingError = Class.new(RuntimeError)

  # Instantiate an RGB colour from a 3- or 6-digit hexadecimal representation.
  # "#abc", "#abcdef", "abc", and "abcdef" are all valid.
  #
  # Invalid representations will raise a ParsingError.
  #
  def hex_color(s)
    if m = s.match(/^#?([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i)
      RGB.new( m[1].to_i(16) / 255.0,
               m[2].to_i(16) / 255.0,
               m[3].to_i(16) / 255.0 )
    elsif m = s.match(/^#?([0-9a-f])([0-9a-f])([0-9a-f])$/i)
      RGB.new( (m[1] + m[1]).to_i(16) / 255.0,
               (m[2] + m[2]).to_i(16) / 255.0,
               (m[3] + m[3]).to_i(16) / 255.0 )
    else
      raise ParsingError, "invalid hex sequence '#{s}'"
    end
  end

  extend self
end

require "colormath/color"
require "colormath/adjust"
require "colormath/blend"
require "colormath/version"
