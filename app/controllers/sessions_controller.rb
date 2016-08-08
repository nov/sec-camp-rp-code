class SessionsController < ApplicationController
  def new
    request_params = {
      scope: [:openid, :email, :profile]
    }
    if params[:re_auth]
      request_params.merge!(
        max_age: 0,
        prompt: :login,
      )
    end
    redirect_to current_client.authorization_uri(request_params)
  end

  def create
    current_client.authorization_code = params[:code]
    access_token = current_client.access_token!
    account = Account.authenticate(access_token)
    account.import! access_token.userinfo! if account.new_record?
    authenticate account
    redirect_to root_url
  end

  def destroy
    unauthenticate!
    redirect_to root_url
  end

  private

  def current_client
    @client ||= Client.first
  end
end
