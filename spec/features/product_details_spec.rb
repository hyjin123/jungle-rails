require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  scenario "They can click on the product and visit the product detail page" do
    # visit the home page
    visit root_path

    # click on the product
    click_link('Details', match: :first)

    # be re-directed to the product page
    expect(page).to have_css 'section.products-show'

    # DEBUG / VERIFY
    save_screenshot

  end

end
