require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validation' do

    let(:category) {Category.new(name: "Furniture") }
    let(:product) {Product.new(name: "Rocking Chair", 
      price_cents: 4000, 
      quantity: 4, 
      category: category)}

    it 'it is valid with all 4 attributes' do
      expect(product).to be_valid
    end

    it 'it is not valid without name' do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it 'it is not valid without price' do
      product.price_cents = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include ("Price can't be blank")
    end

    it 'it is not valid without quantity' do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Quantity can't be blank"]
    end


    it 'it is not valid without category' do
      product.category = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Category can't be blank"]
    end
  end

end
