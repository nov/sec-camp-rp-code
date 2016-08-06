class SessionsController < ApplicationController
  def new
    redirect_to current_client.authorization_uri(
      max_age: 0,
      prompt: :login,
      scope: [:openid, :email, :profile]
    )
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
