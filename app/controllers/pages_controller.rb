class PagesController < ApplicationController
  def home
    redirect_to articles_path if (logged_in?())
  end

  def about
  end

  def game
  end
end
 