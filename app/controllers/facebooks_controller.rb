class FacebooksController < ApplicationController
  before_action :get_user_details
  before_action :create_graph_api_object, only: [:show, :create]

  def login
    response_body = get_api_request "oauth/access_token?
    client_id=#{ENV["app_id"]}&client_secret=#{ENV["app_secret"]}&code=#{params[:code]}&redirect_uri=#{login_url}"
    access_token = response_body["access_token"]
    details = get_api_request "me?fields=email,name&access_token=#{access_token}"
    user = User.find_by email: details["email"]
    if !user
      user = User.create email: details["email"], name: details["name"], password: Devise.friendly_token, access_token: access_token
    else
      user.update_attributes access_token: access_token
    end
    sign_in user
    redirect_to new_facebook_path
  end

  def show
    @edge = @graph.get_connections params[:node], params[:edge], fields: params[:fields]
  end

  def new
  end

  def create
     responses = @graph.get_connections "me", "accounts"
     graph_page = Koala::Facebook::API.new responses[0]["access_token"]
    if params[:publish]
      responses = graph_page.put_connections "me","feed", message: params[:message]
      # responses = graph_page.put_object nil,"2779270585446576_2786495418057426", message: params[:message]
      # responses = graph_page.put_comment "2779270585446576_2786495418057426", params[:message]
      # responses = graph_page.put_like "2573340392737278_2590531271018190"
    elsif params[:edit]
      most_recent_post = graph_page.get_connections("me", "feed")[0]
      responses = graph_page.put_object nil, most_recent_post["id"], message: params[:message], fields: "id"
    elsif params[:batch]
      most_recent_post = graph_page.get_connections("me", "feed")[0]
      responses = graph_page.batch do |batch_api|
        params[:comment].split(";").each do |comment|
          batch_api.put_comment most_recent_post["id"], comment
        end
        batch_api.put_like most_recent_post["id"]
      end
      responses = responses[0]
    else
      responses = @graph.put_connections "me", "feed", message: params[:message]
    end
    redirect_to "https://www.facebook.com/#{responses["id"]}"
  end

  def edit
  end

  def update
    responses = @graph.get_connections "me", "accounts"
    graph_page = Koala::Facebook::API.new responses[0]["access_token"]
    most_recent_post = graph_page.get_connections("me", "feed")[0]
    responses = graph_page.put_object most_recent_post, message: params[:message]
    redirect_to "https://www.facebook.com/#{responses["id"]}"
  end

  private
    def create_graph_api_object
      @graph = Koala::Facebook::API.new current_user.access_token
    end

    def get_api_request endpoint
      uri = URI "https://graph.facebook.com/v3.2/#{endpoint}"
      response_body = JSON.parse Net::HTTP.get_response(uri).body
    end
end
