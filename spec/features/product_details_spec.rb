require 'rails_helper'

RSpec.feature "Click Products Detail", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see one product" do
    # ACT
    visit root_path

    # click_on "Details"
    @one_product = first(".product")
    within(@one_product) do
      click_on("Details")
      
      page.should have_content
     
      save_screenshot

      #DEBUG /VERIFY
      puts page.html
    end

    # DEBUG / VERIFY
    # expect(page).to have_css "article.product", count: 10
  end

end