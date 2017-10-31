class StaticPagesController < ApplicationController
  def home
    @post = Post.first
  end

  def help
  end

  def contact
  end

  def about
  end
end
