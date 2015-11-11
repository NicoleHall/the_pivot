require "test_helper"

class UserCanInteractWithCartTest < ActionDispatch::IntegrationTest
  test "user can add item to cart" do
    create_pursuits(1, "Hiking")
    pursuit = Activity.find_by_name("Hiking").pursuits.first
    visit pursuit_path(pursuit)

    assert page.has_content?("Trips: 0")

    click_link "Purchase Trip"

    assert_equal new_cart_pursuit_path, current_path

    fill_in "Travellers", with: 2
    click_button "Place Order"

    assert page.has_content?("Trips: 1")
    assert_equal pursuits_path, current_path
    assert page.has_content?("You have added Hiking the Alps 1 to your cart.")
  end

  test "user can view cart" do
    visit pursuits_path
    add_items_to_cart(2)
    click_link "View Cart"

    assert_equal "/cart", current_path

    assert page.has_content?("Hiking the Alps 1")
    assert page.has_content?("Go hike the alps! 1")
    assert page.has_content?("$1,001")

    assert page.has_content?("Total: $2,002") # And I should see a small image
  end

  def add_items_to_cart(num)
    num.times do |i|
      i += 1
      create_pursuits(1, "Hiking #{i}")
      pursuit = Activity.find_by_name("Hiking #{i}").pursuits.first

      visit pursuit_path(pursuit)
      click_link "Purchase Trip"

      fill_in "Travellers", with: i
      click_button "Place Order"
    end
  end
end
