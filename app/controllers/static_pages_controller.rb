class StaticPagesController < ApplicationController
  def home
    @disable_nav = true
  end

  def about
  end

  def guidelines
  end

  def team
  end

  def credits
  end
end
