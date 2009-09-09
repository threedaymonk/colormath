module ColorMath
  class HSL
    include Color

    attr_reader :hue, :saturation, :luminance, :alpha

    def initialize(h, s, l)
      @hue        = force_range(h, 0, 360).to_f
      @saturation = force_range(s, 0,   1).to_f
      @luminance  = force_range(l, 0,   1).to_f
    end

    def red
      t = component(hk + (1/3.0))
    end

    def green
      t = component(hk)
    end

    def blue
      t = component(hk - (1/3.0))
    end

  private
    def hk
      hue / 360.0
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
      t = if t < 0
        t + 1.0
      elsif t > 1
        t - 1.0
      else
        t
      end

      if t < (1/6.0)
        p + ((q - p) * 6.0 * t)
      elsif (1/6.0) <= t && t < 0.5
        q
      elsif 0.5 <= t && t < (2/3.0)
        p + ((q - p) * 6.0 * (2/3.0 - t))
      else
        p
      end
    end
  end
end
