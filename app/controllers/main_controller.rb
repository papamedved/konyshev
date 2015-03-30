class MainController < ApplicationController
  def index
    @pictures = Picture.order('position ASC')
  end

  def contacts
  end

  def about
  end
end
