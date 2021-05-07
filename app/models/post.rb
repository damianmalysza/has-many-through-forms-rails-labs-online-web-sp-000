class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(attributes)
    attributes.values.each do |attribute|
      unless attribute["name"].empty?
        category = Category.find_or_create_by(attribute)
        self.categories << category
      end
    end
  end

  def unique_commenters
    commenters = []
    self.comments.each do |comment|
      commenters << comment.user
    end
    commenters.uniq
  end

end
