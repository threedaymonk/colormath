$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

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

  should "have a hue of zero if it is white" do
    c = ColorMath::RGB.new(1, 1, 1)
    assert_equal 0, c.hue
  end
end
