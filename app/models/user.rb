class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #フォローする側のデータを取得
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  #フォローしているuserたちのデータを取得
  has_many :followings, through: :relationships, source: :followed
  #フォローされているuserたちのデータを取得
  has_many :reverse_of_relations, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  #フォロワーのデータを取得
  has_many :followers, through: :reverse_of_relations, source: :follower

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, presence: false, length: { maximum: 50 }


  def following?(another_user)
    followings.include?(another_user)
  end

  def followed_by?(user)
    relationships.find_by(followed_id: user.id).present?
  end

  def favorited_by?(user)
	 favorites.where(user_id: user.id).exists?
  end
  
  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end 
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
end
