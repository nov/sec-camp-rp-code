class Client < ApplicationRecord
  delegate :authorization_uri, :authorization_code=, :access_token!, to: :connect_client

  private

  def connect_client
    @connect_client ||= OpenIDConnect::Client.new(
      identifier: identifier,
      secret: secret,
      redirect_uri: redirect_uri,
      authorization_endpoint: authorization_endpoint,
      token_endpoint: token_endpoint,
      userinfo_endpoint: userinfo_endpoint
    )
  end
end
