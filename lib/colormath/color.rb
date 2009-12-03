module ColorMath

  # Color can be mixed into any class that responds to red, green, and blue, where 0 <= c <= 1
  #
  module Color

    # The six-digit hexadecimal representation of the colour, e.g. "#cafe66"
    #
    def hex
      "#%02x%02x%02x" % [red * 0xff, green * 0xff, blue * 0xff]
    end

    # The hexadecimal representation of the colour, using 3 digits if possible
    #
    def compact_hex
      case h = hex
      when /^#(.)\1(.)\2(.)\3$/
        "##$1#$2#$3"
      else
        h
      end
    end

    def inspect(*args)
      "<%s r=%0.3f g=%0.3f b=%0.3f>" % [self.class.to_s, red, green, blue]
    end

  private
    def force_range(v, min, max)
      [[min, v].max, max].min
    end
  end
end

require "colormath/color/rgb"
require "colormath/color/hsl"
