module ReviewsHelper
  def round_to_nearest_half(num)
    (num * 2.0).round / 2.0
  end
end