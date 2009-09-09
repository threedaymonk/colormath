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
