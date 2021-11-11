class AboutController < ApplicationController
  def index
    @product1 = Product.find_by(id: 6)
    @product2 = Product.find_by(id: 11)
  end
end
