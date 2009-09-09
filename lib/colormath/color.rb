module ColorMath

  # Color can be mixed into any class that responds to red, green, and blue, where 0 <= c <= 1
  #
  module Color
    EPSILON = 1/256.0

    # Returns true if the RGB components of the two colours differ by less than EPSILON,
    # i.e. they are the same when represented in 8 bits.
    #
    def ==(other)
      deltas = [ other.red   - self.red,
                 other.green - self.green,
                 other.blue  - self.blue ].map{ |e| e.abs }
      deltas.max < EPSILON
    end

    # The six-digit hexadecimal representation of the colour, e.g. "#cafe66"
    #
    def hex
      "#%02x%02x%02x" % [red * 0xff, green * 0xff, blue * 0xff]
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
