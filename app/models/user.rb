class User < ApplicationRecord
    has_secure_password
    # def self.user_from_api(result)
    #     self.find_or_create_by(
    #       id: result['id'],
    #       username: result['username'],
    #       email: result['email'],
    #       password_digest: result['password_digest']
    #     )
    # end
end
