module ColorMath
  class RGB
    include Color

    attr_reader :red, :green, :blue

    def initialize(r, g, b)
      @red   = force_range(r, 0, 1).to_f
      @green = force_range(g, 0, 1).to_f
      @blue  = force_range(b, 0, 1).to_f
    end

    def hue
      case max
      when red
        (60.0 * ((green - blue) / (max - min))) % 360.0
      when green
        60.0 * ((blue - red) / (max - min)) + 120.0
      when blue
        60.0 * ((red - green) / (max - min)) + 240.0
      end
    end

    def saturation
      if max == min
        0
      elsif luminance <= 0.5
        (max - min) / (2.0 * luminance)
      else
        (max - min) / (2.0 - 2.0 * luminance)
      end
    end

    def luminance
      0.5 * (max + min)
    end

  private
    def min
      [red, green, blue].min
    end

    def max
      [red, green, blue].max
    end
  end
end
