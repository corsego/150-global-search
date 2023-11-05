class DashboardController < ApplicationController
  def index
    @posts = Post.all
    @tags = Tag.all
    @users = User.all
  end
end