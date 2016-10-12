class Post < ActiveRecord::Base
  belongs_to :user
  def to_liquid
    { 'author'=>self.user.username,
      'body'=>self.content,
      'posted_at'=>self.created_at.strftime('%D') }
  end
end

