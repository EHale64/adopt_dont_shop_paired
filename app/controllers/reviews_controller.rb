class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/new"
      flash[:error] = "You must fill out Title, Rating, and Content to submit a review."
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    #require "pry"; binding.pry
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save(review_params)
      redirect_to "/shelters/#{review.shelter_id}"
    else
      flash[:error] = "You must fill out Title, Rating, and Content to submit a review."
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  private
  def review_params
    params.permit(:title, :content, :rating, :picture, :shelter_id)
  end
end
