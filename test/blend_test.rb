$:.unshift(File.dirname(__FILE__) + '/../lib')
require "test/unit"
require "shoulda"
require "colormath"

class AlphaBlendTest < Test::Unit::TestCase
  def blend(a, b, alpha)
    ColorMath::Blend.alpha(ColorMath::hex_color(a), ColorMath::hex_color(b), alpha).hex
  end

  context "with sample colors" do
    setup do
      @background = "#ffffff"
      @foreground = "#862e8b"
    end

    should "blend 0% sample" do
      assert_equal @background, blend(@background, @foreground, 0.0)
    end

    should "blend 10% sample" do
      assert_equal "#f2eaf3", blend(@background, @foreground, 0.1)
    end

    should "blend 30% sample" do
      assert_equal "#dac0dc", blend(@background, @foreground, 0.3)
    end

    should "blend 100% sample" do
      assert_equal @foreground, blend(@background, @foreground, 1.0)
    end
  end
end
