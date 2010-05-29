module ColorMath

  # A colour represented and stored as hue, saturation and luminance components
  #
  class HSL
    include Color

    attr_reader :hue, :saturation, :luminance, :alpha

    # Initialize an HSL colour where:
    #     0 <= h <= 360
    #     0 <= s <=   1
    #     0 <= l <=   1
    #
    # Saturation and luminance values outside these ranges will be clipped.
    # Hue values will be mapped to a circle, so that e.g. -20 becomes 340.
    #
    def initialize(h, s, l)
      @hue        = h % 360
      @saturation = force_range(s, 0, 1).to_f
      @luminance  = force_range(l, 0, 1).to_f
    end

    # The red component of the colour in RGB representation where 0 <= r <= 1
    #
    def red
      @red ||= component(hk + (1/3.0))
    end

    # The green component of the colour in RGB representation where 0 <= g <= 1
    #
    def green
      @green ||= component(hk)
    end

    # The blue component of the colour in RGB representation where 0 <= b <= 1
    #
    def blue
      @blue ||= component(hk - (1/3.0))
    end

  private
    def hk
      @hk ||= hue / 360.0
    end

    def q
      @q ||= if luminance < 0.5
        luminance * (1.0 + saturation)
      else
        luminance + saturation - (luminance * saturation)
      end
    end

    def p
      @p ||= 2 * luminance - q
    end

    def component(t)
      if t < 0
        t += 1.0
      elsif t > 1
        t -= 1.0
      end

      if t < (1/6.0)
        p + ((q - p) * 6.0 * t)
      elsif t < 0.5
        q
      elsif t < (2/3.0)
        p + ((q - p) * 6.0 * (2/3.0 - t))
      else
        p
      end
    end
  end
end
