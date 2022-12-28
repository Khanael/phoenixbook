class VotesController < ApplicationController

  def index
    @votes = Vote.where(user_id: current_user.id, liked: true)
  end

  def create
    @vote = Vote.new

    @vote.liked = true if params[:liked] == "true"
    @vote.user_id = current_user.id
    @vote.book_id = params[:book_id]
    if @vote.save!
      redirect_to :votes
    else
      render :back
    end
  end

  def update
    @vote = Vote.find(params[:id])
    @vote.liked = !@vote.liked
    redirect_to :back
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    redirect_to :back
  end
end
