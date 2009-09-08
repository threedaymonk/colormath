module ColorMath
  class Color
    EPSILON = 1/256.0

    def ==(other)
      deltas = [ other.red   - self.red,
                 other.green - self.green,
                 other.blue  - self.blue ].map{ |e| e.abs }
      deltas.max < EPSILON
    end

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
