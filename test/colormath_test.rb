$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

class HexDecodingTest < Test::Unit::TestCase
  EPSILON = 1e-3

  should "decode 6-digit hex string with leading #" do
    c = ColorMath::hex_color("#abcd54")
    assert_in_delta (0xab / 255.0), c.red,   EPSILON
    assert_in_delta (0xcd / 255.0), c.green, EPSILON
    assert_in_delta (0x54 / 255.0), c.blue,  EPSILON
  end

  should "decode 6-digit hex string without leading #" do
    c = ColorMath::hex_color("abcd54")
    assert_in_delta (0xab / 255.0), c.red,   EPSILON
    assert_in_delta (0xcd / 255.0), c.green, EPSILON
    assert_in_delta (0x54 / 255.0), c.blue,  EPSILON
  end

  should "decode 3-digit hex string with leading #" do
    c = ColorMath::hex_color("#a1c")
    assert_in_delta (0xaa / 255.0), c.red,   EPSILON
    assert_in_delta (0x11 / 255.0), c.green, EPSILON
    assert_in_delta (0xcc / 255.0), c.blue,  EPSILON
  end

  should "decode 3-digit hex string without leading #" do
    c = ColorMath::hex_color("a1c")
    assert_in_delta (0xaa / 255.0), c.red,   EPSILON
    assert_in_delta (0x11 / 255.0), c.green, EPSILON
    assert_in_delta (0xcc / 255.0), c.blue,  EPSILON
  end
end

class HSLTest < Test::Unit::TestCase
  should "be equal if initialized with same values" do
    assert_equal ColorMath::HSL.new(123, 0.5, 0.7), ColorMath::HSL.new(123, 0.5, 0.7)
  end

  should "not be equal if initialized with different values" do
    assert_not_equal ColorMath::HSL.new(124, 0.4, 0.8), ColorMath::HSL.new(123, 0.5, 0.7)
  end

  should "force hue >= 0" do
    c = ColorMath::HSL.new(-2, 0, 0)
    assert_equal 0, c.hue
  end

  should "force hue <= 360" do
    c = ColorMath::HSL.new(361, 0, 0)
    assert_equal 360, c.hue
  end

  should "force saturation >= 0" do
    c = ColorMath::HSL.new(0, -1, 0)
    assert_equal 0, c.saturation
  end

  should "force saturation <= 1" do
    c = ColorMath::HSL.new(0, 1.1, 0)
    assert_equal 1, c.saturation
  end

  should "force luminance >= 0" do
    c = ColorMath::HSL.new(0, 0, -1)
    assert_equal 0, c.luminance
  end

  should "force luminance <= 1" do
    c = ColorMath::HSL.new(0, 0, 1.1)
    assert_equal 1, c.luminance
  end
end

class RGBTest < Test::Unit::TestCase
  should "be equal if initialized with same values" do
    assert_equal ColorMath::RGB.new(0.3, 0.5, 0.7), ColorMath::RGB.new(0.3, 0.5, 0.7)
  end

  should "not be equal if initialized with different values" do
    assert_not_equal ColorMath::RGB.new(0.5, 0.4, 0.8), ColorMath::RGB.new(0.3, 0.5, 0.7)
  end

  should "force red >= 0" do
    c = ColorMath::HSL.new(-2, 0, 0)
    assert_equal 0, c.red
  end

  should "force red <= 1" do
    c = ColorMath::RGB.new(1.1, 0, 0)
    assert_equal 1, c.red
  end

  should "force green >= 0" do
    c = ColorMath::RGB.new(0, -1, 0)
    assert_equal 0, c.green
  end

  should "force green <= 1" do
    c = ColorMath::RGB.new(0, 1.1, 0)
    assert_equal 1, c.green
  end

  should "force blue >= 0" do
    c = ColorMath::RGB.new(0, 0, -1)
    assert_equal 0, c.blue
  end

  should "force blue <= 1" do
    c = ColorMath::RGB.new(0, 0, 1.1)
    assert_equal 1, c.blue
  end
end

class ConversionTest < Test::Unit::TestCase
  EPSILON = 1e-2

  EDGE_CASES = [
    [[1,   0,   0], [  0, 1, 0.5 ]],
    [[0.5, 1, 0.5], [120, 1, 0.75]],
    [[0,   0, 0.5], [240, 1, 0.25]],
  ]

  context "with edge cases" do
    EDGE_CASES.each do |(r,g,b), (h,s,l)|
      should "convert RGB(#{r},#{g},#{b}) to HSL(#{h},#{s},#{l})" do
        c = ColorMath::RGB.new(r, g, b)
        assert_in_delta h, c.hue,        EPSILON
        assert_in_delta s, c.saturation, EPSILON
        assert_in_delta l, c.luminance,  EPSILON
      end

      should "convert HSL(#{h},#{s},#{l}) to RGB(#{r},#{g},#{b})" do
        c = ColorMath::HSL.new(h, s, l)
        assert_in_delta r, c.red,   EPSILON
        assert_in_delta g, c.green, EPSILON
        assert_in_delta b, c.blue,  EPSILON
      end
    end
  end

  HSL_SAMPLES = [
    [267.0, 0.14, 0.17],
    [322.0, 0.22, 0.54],
    [211.0, 0.54, 0.19],
    [347.0, 0.90, 0.38],
    [184.0, 0.75, 0.13],
    [177.0, 0.07, 0.14],
    [ 97.0, 0.93, 0.70],
    [139.0, 0.04, 0.37],
    [ 17.0, 0.88, 0.67],
    [162.0, 0.21, 0.61],
    [358.0, 0.78, 0.50],
    [104.0, 0.78, 0.63],
    [280.0, 0.38, 0.66],
    [298.0, 0.06, 0.72],
    [162.0, 0.39, 0.86],
    [305.0, 0.55, 0.16],
    [248.0, 0.80, 0.84],
    [109.0, 0.23, 0.23],
    [328.0, 0.88, 0.88],
    [ 26.0, 0.99, 0.52],
  ]

  context "roundtripping HSL -> RGB -> HSL" do
    HSL_SAMPLES.each do |h,s,l|
      should "roundtrip HSL(#{h},#{s},#{l})" do
        hsl = ColorMath::HSL.new(h, s, l)
        rgb = ColorMath::RGB.new(hsl.red, hsl.green, hsl.blue)

        assert_in_delta h, rgb.hue,        EPSILON
        assert_in_delta s, rgb.saturation, EPSILON
        assert_in_delta l, rgb.luminance,  EPSILON
      end
    end
  end

  RGB_SAMPLES = [
    [0.19, 0.41, 0.70],
    [0.13, 0.22, 0.28],
    [0.45, 0.44, 0.24],
    [0.96, 0.94, 0.24],
    [0.76, 0.01, 0.16],
    [0.55, 0.96, 0.01],
    [0.07, 0.61, 0.73],
    [0.05, 0.58, 0.51],
    [0.43, 0.05, 0.24],
    [0.66, 0.80, 0.80],
    [0.54, 0.35, 0.10],
    [0.12, 0.41, 0.27],
    [0.78, 0.32, 0.93],
    [0.52, 0.15, 0.43],
    [0.17, 0.26, 0.53],
    [0.19, 0.96, 0.66],
    [0.54, 0.36, 0.84],
    [0.12, 0.89, 0.60],
    [0.75, 0.03, 0.83],
    [0.09, 0.35, 0.83],
  ]

  context "roundtripping RGB -> HSL -> RGB" do
    RGB_SAMPLES.each do |r,g,b|
      should "roundtrip RGB(#{r},#{g},#{b})" do
        rgb = ColorMath::RGB.new(r, g, b)
        hsl = ColorMath::HSL.new(rgb.hue, rgb.saturation, rgb.luminance)

        assert_in_delta r, hsl.red,   EPSILON
        assert_in_delta g, hsl.green, EPSILON
        assert_in_delta b, hsl.blue,  EPSILON
      end
    end
  end
end

class BlendTest < Test::Unit::TestCase
  def c(s)
    ColorMath::hex_color(s)
  end

  context "with sample colors" do
    setup do
      @background = c("#ffffff")
      @foreground = c("#862e8b")
    end

    should "blend 0% sample" do
      assert_equal @background, ColorMath::Blend.alpha(@background, @foreground, 0.0)
    end

    should "blend 10% sample" do
      assert_equal c("#f2eaf3"), ColorMath::Blend.alpha(@background, @foreground, 0.1)
    end

    should "blend 30% sample" do
      assert_equal c("#dac0dc"), ColorMath::Blend.alpha(@background, @foreground, 0.3)
    end

    should "blend 100% sample" do
      assert_equal @foreground, ColorMath::Blend.alpha(@background, @foreground, 1.0)
    end
  end
end
