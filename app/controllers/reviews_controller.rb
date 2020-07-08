class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    @review = Review.create(review_params)
    if @review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/new"
      flash[:error] = "You must fill out Title, Rating, and Content to submit a review."
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    require "pry"; binding.pry
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def review_params
    params.permit(:title, :content, :rating, :picture, :shelter_id)
  end
end
