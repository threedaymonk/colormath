module ColorMath
  module Blend
    def alpha(ca, cb, alpha)
      for_rgb(ca, cb){ |a, b| (alpha * b + (1 - alpha) * a) }
    end

    extend self

  private
    def for_rgb(a, b, &blk)
      RGB.new(*([:red, :green, :blue].map{ |channel|
        blk.call(a.__send__(channel), b.__send__(channel))
      }))
    end
  end
end
