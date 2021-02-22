require "test_helper"

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get preferences_index_url
    assert_response :success
  end

  test "should get show" do
    get preferences_show_url
    assert_response :success
  end

  test "should get new" do
    get preferences_new_url
    assert_response :success
  end

  test "should get edit" do
    get preferences_edit_url
    assert_response :success
  end

  test "should get delete" do
    get preferences_delete_url
    assert_response :success
  end
end
