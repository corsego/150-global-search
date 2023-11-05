class DashboardController < ApplicationController
  SEARCHABLE_MODEL_ATTRIBUTES = {
    "Post" => ["title", "description"],
    "Tag" => ["name"],
    "User" => ["first_name", "last_name", "email"]
    # "User" => ["first_name", "last_name"]
  }

  def index
    # @posts = Post.all
    # @tags = Tag.all
    # @users = User.all

    # if params[:query].present?
    #   @tags = Tag.where("name ILIKE ?", "%#{params[:query]}%")
    #   @posts = Post.where("title ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    #   @users = User.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    # else
    #   @posts = []
    #   @tags = []
    #   @users = []
    # end

    @search_results = {}

    if params[:query].present?
      SEARCHABLE_MODEL_ATTRIBUTES.each do |model_name, searchable_fields|
        model_results = model_name.constantize.where(searchable_fields.map { |field| "#{field} ILIKE :query" }.join(" OR "), query: "%#{params[:query]}%")
        @search_results[model_name] = model_results
      end
    end
  end
end