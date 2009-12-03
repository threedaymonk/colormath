$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

class AdjustmentTest < Test::Unit::TestCase
  include ColorMath
  EPSILON = 1e-3

  context "in the HSL space" do
    should "rotate hue" do
      c = HSL.new(180, 0.5, 0.5)
      assert_equal 120, Adjust.hue(c,  -60).hue
      assert_equal 340, Adjust.hue(c, -200).hue
      assert_equal 240, Adjust.hue(c,   60).hue
      assert_equal  20, Adjust.hue(c,  200).hue
    end

    should "adjust saturation" do
      c = HSL.new(180, 0.5, 0.5)
      assert_in_delta 0.2, Adjust.saturation(c, -0.3).saturation, EPSILON
      assert_in_delta 0.0, Adjust.saturation(c, -0.6).saturation, EPSILON
      assert_in_delta 0.8, Adjust.saturation(c,  0.3).saturation, EPSILON
      assert_in_delta 1.0, Adjust.saturation(c,  0.6).saturation, EPSILON
    end

    should "adjust luminance" do
      c = HSL.new(180, 0.5, 0.5)
      assert_in_delta 0.2, Adjust.luminance(c, -0.3).luminance, EPSILON
      assert_in_delta 0.0, Adjust.luminance(c, -0.6).luminance, EPSILON
      assert_in_delta 0.8, Adjust.luminance(c,  0.3).luminance, EPSILON
      assert_in_delta 1.0, Adjust.luminance(c,  0.6).luminance, EPSILON
    end

    should "not affect unrelated parameters" do
      c = HSL.new(180, 0.4, 0.6)
      assert_in_delta 180, Adjust.saturation(c, -0.3).hue, EPSILON
      assert_in_delta 180, Adjust.luminance(c, -0.3).hue, EPSILON
      assert_in_delta 0.4, Adjust.hue(c, -20).saturation, EPSILON
      assert_in_delta 0.4, Adjust.luminance(c, -0.3).saturation, EPSILON
      assert_in_delta 0.6, Adjust.hue(c, -20).luminance, EPSILON
      assert_in_delta 0.6, Adjust.saturation(c, -0.3).luminance, EPSILON
    end
  end

  context "in the RGB space" do
    should "adjust red" do
      c = RGB.new(0.5, 0.3, 0.4)
      assert_in_delta 0.2, Adjust.red(c, -0.3).red, EPSILON
      assert_in_delta 0.0, Adjust.red(c, -0.6).red, EPSILON
      assert_in_delta 0.8, Adjust.red(c,  0.3).red, EPSILON
      assert_in_delta 1.0, Adjust.red(c,  0.6).red, EPSILON
    end

    should "adjust green" do
      c = RGB.new(0.3, 0.5, 0.4)
      assert_in_delta 0.2, Adjust.green(c, -0.3).green, EPSILON
      assert_in_delta 0.0, Adjust.green(c, -0.6).green, EPSILON
      assert_in_delta 0.8, Adjust.green(c,  0.3).green, EPSILON
      assert_in_delta 1.0, Adjust.green(c,  0.6).green, EPSILON
    end

    should "adjust blue" do
      c = RGB.new(0.3, 0.4, 0.5)
      assert_in_delta 0.2, Adjust.blue(c, -0.3).blue, EPSILON
      assert_in_delta 0.0, Adjust.blue(c, -0.6).blue, EPSILON
      assert_in_delta 0.8, Adjust.blue(c,  0.3).blue, EPSILON
      assert_in_delta 1.0, Adjust.blue(c,  0.6).blue, EPSILON
    end

    should "not affect unrelated parameters" do
      c = RGB.new(0.3, 0.4, 0.5)
      assert_in_delta 0.3, Adjust.green(c, -0.3).red, EPSILON
      assert_in_delta 0.3, Adjust.blue(c, -0.3).red, EPSILON
      assert_in_delta 0.4, Adjust.red(c, -0.3).green, EPSILON
      assert_in_delta 0.4, Adjust.blue(c, -0.3).green, EPSILON
      assert_in_delta 0.5, Adjust.red(c, -0.3).blue, EPSILON
      assert_in_delta 0.5, Adjust.green(c, -0.3).blue, EPSILON
    end
  end
end
