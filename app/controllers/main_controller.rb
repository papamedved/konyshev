class MainController < ApplicationController
  def index
    @pictures = Picture.all
  end
end
