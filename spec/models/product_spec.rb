require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should succesfully create a new product if all fields are filled' do
      @category = Category.new(name: "Gadgets")
      @category.save!
      @product = Product.new(name: "Arduino", price: 50, quantity: 10, category: @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it 'should not succesfully save when name field is empty in product' do
      @category = Category.new(name: "Gadgets")
      @category.save!
      @product = Product.new(name: nil, price: 85, quantity: 2, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not succesfully save when price field is empty in product' do
      @category = Category.new(name: "Gadgets")
      @category.save!
      @product = Product.new(name: "RaspberryPi", price: nil, quantity: 10, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
    
    it 'should not succesfully save when quantity field is empty in product' do
      @category = Category.new(name: "Gadgets")
      @category.save!
      @product = Product.new(name: "Ultrasonic Sensor", price: 5, quantity: nil, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should not succesfully save when category field is empty in product' do
      @product = Product.new(name: "Ultrasonic Sensor", price: 5, quantity: nil, category: nil)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  
  
  end

end
