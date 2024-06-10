class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name:ENV['ADMIN_USERNAME'], password:ENV['ADMIN_PASSWORD'], only: [:index,:new]

  def show

    @productCount = Product.count
    @categoryCount = Category.count
    @product = Product.all
    @category = Category.all
  end
end
