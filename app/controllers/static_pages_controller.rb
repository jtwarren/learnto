class StaticPagesController < ApplicationController
  def home
    @disable_nav = true
  end

  def about
  end
end
