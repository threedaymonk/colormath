module ColorMath

  # Adjust parameters of a colour
  #
  module Adjust

    # Rotate the hue by delta degrees in either direction
    def hue(color, delta)
      HSL.new(color.hue + delta, color.saturation, color.luminance)
    end

    # Adjust the saturation by delta, stopping at 0 or 1
    def saturation(color, delta)
      HSL.new(color.hue, color.saturation + delta, color.luminance)
    end

    # Adjust the luminance by delta, stopping at 0 or 1
    def luminance(color, delta)
      HSL.new(color.hue, color.saturation, color.luminance + delta)
    end

    # Adjust the red component by delta, stopping at 0 or 1
    def red(color, delta)
      RGB.new(color.red + delta, color.green, color.blue)
    end

    # Adjust the green component by delta, stopping at 0 or 1
    def green(color, delta)
      RGB.new(color.red, color.green + delta, color.blue)
    end

    # Adjust the blue component by delta, stopping at 0 or 1
    def blue(color, delta)
      RGB.new(color.red, color.green, color.blue + delta)
    end

    extend self
  end
end
