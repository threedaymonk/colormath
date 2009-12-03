
$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

class HexEncodingTest < Test::Unit::TestCase

  should "generate hex code" do
    %w[ #123456 #abcdef #000000 #ffffff #112233 #aabbcc ].each do |hex|
      assert_equal hex, ColorMath::hex_color(hex).hex
    end
  end

  context "when generating short hex code" do
    should "use three digits if possible" do
      assert_equal "#000", ColorMath::hex_color("#000000").compact_hex
      assert_equal "#fff", ColorMath::hex_color("#ffffff").compact_hex
      assert_equal "#123", ColorMath::hex_color("#112233").compact_hex
      assert_equal "#abc", ColorMath::hex_color("#aabbcc").compact_hex
    end

    should "use six digits if not possible" do
      %w[ #123456 #abcdef ].each do |hex|
        assert_equal hex, ColorMath::hex_color(hex).compact_hex
      end
    end
  end

end
