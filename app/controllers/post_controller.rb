class PostController < ApplicationController

  def index
    data = Post.limit 100
    response = { results: data }
    render :json => response
  end

end
