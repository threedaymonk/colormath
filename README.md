ColorMath
=========

A simple Ruby library to perform operations on RGB and HSL colours.

Usage
-----

Instantiate an RGB (red, green, blue) colour:

    orange = ColorMath::RGB.new(1.0, 0.5, 0)

Or from a hex value via a helper method:

    white  = ColorMath::hex_color("#fff")
    blue   = ColorMath::hex_color("#0000ff")

Instantiate an HSL (hue, saturation, luminance) colour:

    pink   = ColorMath::HSL.new(350, 1, 0.88)

Retrieve the RGB components of a colour:

    pink.red    # => 1.0
    pink.green  # => 0.76
    pink.blue   # => 0.8

Or the HSL components:

    orange.hue         # => 30.0
    orange.saturation  # =>  1.0
    orange.luminance   # =>  0.5

Combine two colours via an alpha blend, e.g. 30% orange on white:

    combined = ColorMath::Blend.alpha(white, orange, 0.3)

Convert a colour to hexadecimal representation:

    combined.hex  # => "#ffd8b2"

That’s it. It only does the basics that I need for the job in hand, but it’s probably a good basis for extension.
