$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

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
