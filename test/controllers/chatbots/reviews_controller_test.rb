require "test_helper"

class Chatbots::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chatbots_reviews_index_url
    assert_response :success
  end
end
