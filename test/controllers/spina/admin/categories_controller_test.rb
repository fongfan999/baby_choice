require 'test_helper'

class Spina::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spina_admin_categories_index_url
    assert_response :success
  end

end
