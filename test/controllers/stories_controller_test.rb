require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get introduction' do
    get stories_introduction_url
    assert_response :success
  end
end
