require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @cat1 = Category.create(name: 'category1')
    end

    it 'should have a valid test subject' do
      @prod = Product.new(name: 'sleeper', price: 999.99, quantity: 25, category: @cat1)
      expect(@prod).to be_valid
    end

    it 'should not be valid if name is nil' do
      @prod = Product.new(name: nil, price: 999.99, quantity: 25, category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:name]).to include("can't be blank")
    end

    it 'should not be valid if price is nil' do
      @prod = Product.new(name: 'sleeper', price: nil, quantity: 25, category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:price]).to include("can't be blank")
    end

    it 'should not be valid if price is not an integer' do
      @prod = Product.new(name: 'sleeper', price: 'expensive', quantity: 25, category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:price]).to include("is not a number")
    end

    it 'should not be valid if quantity is nil' do
      @prod = Product.new(name: 'sleeper', price: 999.99, quantity: nil, category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:quantity]).to include("can't be blank")
    end

    it 'should not be valid if quantity is not an integer' do
      @prod = Product.new(name: 'sleeper', price: 999.99, quantity: 'twentyfive', category: @cat1)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:quantity]).to include("is not a number")
    end

    it 'should not be valid if category is nil' do
      @prod = Product.new(name: 'sleeper', price: 999.99, quantity: 'twentyfive', category: nil)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:category]).to include("can't be blank")
    end

    it 'should not be valid if category does not exist' do
      @prod = Product.new(name: 'sleeper', price: 999.99, quantity: 'twentyfive', category: @cat2)
      expect(@prod).to_not be_valid
      expect(@prod.errors[:category]).to include("can't be blank")
    end

  end
end
