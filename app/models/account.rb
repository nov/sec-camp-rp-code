class Account < ApplicationRecord
  def import!(userinfo)
    self.name = userinfo.name
    self.email = userinfo.email
    self.save!
  end

  class << self
    def authenticate(token_response)
      id_token = JSON::JWT.decode token_response.id_token, :skip_verification
      find_or_initialize_by(identifier: id_token[:sub])
    end
  end
end
