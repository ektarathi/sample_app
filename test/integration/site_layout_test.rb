require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'

    ## the assertion for the root path verifies that there are two such links (one each for the logo and navigation menu element)
    assert_select "a[href=?]", root_path, count: 2
    
    assert_select "a[href=?]", help_path
    #assert_select "a[href=?]", about_path
    assert_select "a[href=?]", signup_path
  end
end
