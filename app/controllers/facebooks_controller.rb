class FacebooksController < ApplicationController
  before_action :get_user_details
  before_action :create_graph_api_object, only: [:show, :create]

  def login
    response_body = get_api_request "oauth/access_token?
    client_id=#{ENV["app_id"]}&client_secret=#{ENV["app_secret"]}&code=#{params[:code]}&redirect_uri=https://5914e30e.ngrok.io/facebook/login"
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
     # responses = @graph.get_connections "me", "accounts"
     # graph_page = Koala::Facebook::API.new responses[0]["access_token"]
     page_response = get_api_request "me" , "accounts"
     page_access_token = page_response["access_token"]
    if params[:page]
      # responses = graph_page.put_connections "me","feed", message: params[:message]
      # responses = graph_page.put_object nil,"2779270585446576_2786495418057426", message: params[:message]
      # responses = graph_page.put_comment "2779270585446576_2786495418057426", params[:message]
      # responses = graph_page.put_like "2573340392737278_2590531271018190"
      responses = post_api_request "me/feed?"
    elsif params[:batch]
      feed = graph_page.get_connections "me", "feed"
      responses = graph_page.batch do |batch_api|
        params[:comment].split(";").each do |comment|
          batch_api.put_comment feed[0]["id"], comment
        end
      end
      responses = responses[0]
    else
      responses = @graph.put_connections "me", "feed", message: params[:message]
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
      @graph = Koala::Facebook::API.new current_user.access_token
    end

    def get_api_request endpoint
      uri = URI "https://graph.facebook.com/v3.2/#{endpoint}"
      response_body = JSON.parse Net::HTTP.get_response(uri).body
    end

    def post_page_api_request endpoint, message, fields = 'id', page_token
      uri = URI "https://graph.facebook.com/v3.2/#{endpoint}"
      response_body = JSON.parse Net::HTTP.post_form(uri, 'message' => message,'fields' => fields,'access_token' => page_token).body
    end

    def delete_page_api_request endpoint, page_token
      uri = URI "https://graph.facebook.com/v3.2/#{endpoint}"
      response_body = JSON.parse Net::HTTP.delete(uri, 'access_token' => page_token)
    end

end
