module ColorMath
  ParsingError = Class.new(RuntimeError)

  def hex_color(s)
    if m = s.match(/^#?([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/)
      RGB.new( m[1].to_i(16) / 255.0,
               m[2].to_i(16) / 255.0,
               m[3].to_i(16) / 255.0 )
    elsif m = s.match(/^#?([0-9a-f])([0-9a-f])([0-9a-f])$/)
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
require "colormath/blend"
