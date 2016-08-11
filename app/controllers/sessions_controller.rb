class SessionsController < ApplicationController
  # before_action :validate_state!, only: :create

  def new
    request_params = {
      scope: [:openid, :email, :profile],
      state: (session[:state] = SecureRandom.hex(16)),
      nonce: (session[:nonce] = SecureRandom.hex(16))
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
    account = Account.authenticate access_token.id_token, session.delete(:nonce)
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

  def validate_state!
    unless session.delete(:state) == params[:state]
      raise 'CSRF Attack Detected'
    end
  end
end
