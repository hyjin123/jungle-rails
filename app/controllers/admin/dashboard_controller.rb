class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  
  before_filter :authorize
  
  def show
    @number_of_products = Product.count
    @number_of_categories = Category.count
  end

end
