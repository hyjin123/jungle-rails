require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Can add to cart on the homepage and will increase the cart by 1" do
    # visit the home page
    visit root_path

    # click add-to-cart
    click_on("Add", match: :first)

    # check to see if cart increased by 1
    expect(page).to have_text 'My Cart (1)'

    # DEBUG/VERIFY
    save_screenshot

  end

end
