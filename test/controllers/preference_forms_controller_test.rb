# frozen_string_literal: true

require 'test_helper'

class PreferenceFormsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get preference_forms_index_url
    assert_response :success
  end

  test 'should get new' do
    get preference_forms_new_url
    assert_response :success
  end

  test 'should get edit' do
    get preference_forms_edit_url
    assert_response :success
  end

  test 'should get delete' do
    get preference_forms_delete_url
    assert_response :success
  end
end
