require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @cat1 = Category.create(name: 'category1')
    end

    it 'should have a valid test subject' do
      @prod = Product.new(name: 'sleeper', price: 99.99, quantity: 25, category: @cat1)
      expect(@prod).to be_valid
    end

    it 'should not be valid if name is nil' do
      @prod = Product.new(name: nil, price: 99.99, quantity: 25, category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:name]).to include("can't be blank")
    end

  end
end
