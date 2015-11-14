require 'test_helper'

class AdminDashboardTest < ActionDispatch::IntegrationTest

  test "admin can login and access admin dashboard path" do
    User.create(username: "aaron", name: "Aaron", password: "pass", role: 1)

    visit root_path

    fill_in "Username", with: "aaron"
    fill_in "Password", with: "pass"

    click_button "Login"
    assert admin_dashboard_path, current_path
    assert page.has_content?("Admin Dashboard")
  end

  test "user cannot access admin dashboard" do
    User.create(username: "cole", name: "Cole Hall", password: "password", role: 0)

    visit root_path

    click_button "Login"
    fill_in "Username", with: "cole"
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content?("Welcome, Cole Hall!")
    assert '/dashboard', current_path

    visit admin_dashboard_path
    assert page.has_content?("404")
  end

  test "unregistered user cannot access admin dashboard" do
    visit root_path

    assert page.has_content?("Login")

    visit '/admin/dashboard'

    assert page.has_content?("404")
  end

  test "admin can update their account details but not other user accounts" do
    User.create(username: "aaron", name: "Aaron", password: "pass", role: 1)

    visit root_path

    fill_in "Username", with: "aaron"
    fill_in "Password", with: "pass"

    click_button "Login"
    click_button "Edit Account"

    assert user_path, current_path
    fill_in "Username", with: "acareaga"
    fill_in "Password", with: "passord"
  end
end
