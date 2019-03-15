class FacebooksController < ApplicationController
  before_action :create_graph_api_object, only: [:create, :show]

  def show
    @edge = @graph.get_connections params[:node], params[:edge], fields: params[:fields]
  end

  def new
  end

  def create
    if params[:page]
      responses = @graph.get_connections "me", "accounts"
      graph_page = Koala::Facebook::API.new responses[0]["access_token"]
      # responses = graph_page.put_connections "me","feed", message: params[:message]
      responses = graph_page.put_like "2573340392737278_2580391522032165"
    else
      # responses = @graph.put_connections "me", "feed", message: params[:message]
      responses = @graph.put_comment "2580386812032636", params[:message]
    end
    redirect_to "https://www.facebook.com/#{responses["id"]}"
  end

  def edit
    responses = @graph.get_connections "me", "accounts"
    graph_page = Koala::Facebook::API.new responses[0]["access_token"]
    responses = graph_page.put_object params[:page_id], message: params[:message]
  end

  def update
  end

  private
    def create_graph_api_object
      @graph = Koala::Facebook::API.new params[:access_token]
    end
end
