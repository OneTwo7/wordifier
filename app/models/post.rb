class Post < ApplicationRecord

  default_scope { order(created_at: :desc) }

  belongs_to :user
  validates :title, presence: true, length: { in: 3..54 }
  validates :content, presence: true, length: { minimum: 6 }

  self.per_page = 10

end
