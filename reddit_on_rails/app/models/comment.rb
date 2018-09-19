class Comment < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
    
  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: 'Post'
    
    belongs_to :comment,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: 'Comment',
    optional: true
    
  has_many :child_comments,
    primary_key: :id,
    foreign_key: :comment_id,
    class_name: 'Comment'
    
end