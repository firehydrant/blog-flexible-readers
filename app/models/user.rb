class User < ApplicationRecord
  enum role: [:owner, :admin, :member]
end
