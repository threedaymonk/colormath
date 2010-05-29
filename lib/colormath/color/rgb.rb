module ColorMath

  # A colour represented and stored as red, green and blue components
  #
  class RGB
    include Color

    attr_reader :red, :green, :blue

    # Initialize an RGB colour where:
    #     0 <= r <= 1
    #     0 <= g <= 1
    #     0 <= b <= 1
    #
    # Values outside these ranges will be clippped.
    #
    def initialize(r, g, b)
      @red   = force_range(r, 0, 1).to_f
      @green = force_range(g, 0, 1).to_f
      @blue  = force_range(b, 0, 1).to_f
    end

    # The hue component of the colour in HSL representation where 0 <= h < 360
    #
    def hue
      @hue ||= if saturation.zero?
        0
      else
        case max
        when red
          (60.0 * ((green - blue) / (max - min))) % 360.0
        when green
          60.0 * ((blue - red) / (max - min)) + 120.0
        when blue
          60.0 * ((red - green) / (max - min)) + 240.0
        end
      end
    end

    # The saturation component of the colour in HSL representation where 0 <= s <= 1
    #
    def saturation
      @saturation ||= if max == min
        0
      elsif luminance <= 0.5
        (max - min) / (2.0 * luminance)
      else
        (max - min) / (2.0 - 2.0 * luminance)
      end
    end

    # The luminance component of the colour in HSL representation where 0 <= l <= 1
    #
    def luminance
      @luminance ||= 0.5 * (max + min)
    end

  private
    def min
      @min ||= [red, green, blue].min
    end

    def max
      @max ||= [red, green, blue].max
    end
  end
end
