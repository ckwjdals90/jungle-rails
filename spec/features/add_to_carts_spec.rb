require 'rails_helper'

RSpec.feature "Visitor clicks on add to cart button", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

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

  scenario "They add a product into the cart clicking on the Add page, and see the Cart (1) instead of Cart (0)" do
    # ACT
    visit root_path
    first('article.product').click_on 'Add'

    # DEBUG
    save_screenshot

    # VERIFY
    within "#navbar" do
      expect(page).to have_link('My Cart (1)')
    end
    expect(page.current_path).to eq('/')
  end

  scenario "They add a product into the cart, and go to cart page to see the grand total" do
    # ACT
    visit root_path
    first('article.product').click_on 'Add'
    click_on 'My Cart (1)'

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page.current_path).to eq('/cart')
    expect(page).to have_content 'TOTAL:'
  end

end
