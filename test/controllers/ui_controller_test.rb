# frozen_string_literal: true

require 'test_helper'

class UiControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get ui_index_url
    assert_response :success
  end

  test 'should get CreateProfile' do
    get ui_CreateProfile_url
    assert_response :success
  end

  test 'should get EditProfile' do
    get ui_EditProfile_url
    assert_response :success
  end
end
