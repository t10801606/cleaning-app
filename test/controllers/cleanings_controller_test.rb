require 'test_helper'

class CleaningsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get cleanings_index_url
    assert_response :success
  end
end
