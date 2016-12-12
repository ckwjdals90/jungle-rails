class ProductsController < ApplicationController
  # ========= defalult method names =========
  # index - shows all resources of a certain type.
  # show - show details about a specific resources.
  # create - receive resources data from a form and store it to the database.
  # new - display a form to create a new resource.
  # edit - display a form to edit a resource.
  # update - receive data from an update form and store it in the database.
  # destroy - deletes a resource from the database.

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new(:product=>@product)

  end

end
