module ColorMath

  # Blend two or more colours and return a new colour.
  #
  module Blend

    # Blend ca with cb. alpha represents the proportion of cb,
    # i.e. alpha = 0 => ca; alpha = 1 => cb.
    #
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
