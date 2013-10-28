class StaticPagesController < ApplicationController
  def home
    @disable_nav = true
    @disable_footer = true
  end

  def about
    @disable_footer = true
  end
end
