class StaticPagesController < ApplicationController
  def show
    render "static_pages/home"
  end
end
