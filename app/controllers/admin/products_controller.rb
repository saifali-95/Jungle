require 'dotenv'

class Admin::ProductsController < ApplicationController
  
  #Authenicate username and password before a user can access admin controller
  before_filter :authenticate

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

  #HTTP basic authentication, password and username is being imported from dotenv file.

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["HTTP_username"] && password == ENV["HTTP_password"] 
    end
  end

end
