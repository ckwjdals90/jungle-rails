class ReviewsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @product = Product.find(params[:product_id])
    @reviews = @product.reviews
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product)
    else
      raise "Yay, I'm here!"
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end

  private

    def review_params
      params.require(:review).permit(:description, :rating)
    end

end
