$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

class HSLTest < Test::Unit::TestCase
  should "force hue >= 0" do
    c = ColorMath::HSL.new(-2, 0, 0)
    assert_equal 358, c.hue
  end

  should "force hue <= 360" do
    c = ColorMath::HSL.new(361, 0, 0)
    assert_equal 1, c.hue
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
