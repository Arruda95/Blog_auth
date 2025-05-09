class HomeController < ApplicationController
  def index
    @featured_posts = Post.limit(3)
  end
end