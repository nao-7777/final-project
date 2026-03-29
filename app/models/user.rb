class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # belongs_to :user
  has_many :walks, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # 💡 追加：レベルに応じて画像名を返すメソッド
  def fox_image_name
    if level && level >= 10
      "fox_stage2.png" # 進化後のファイル名
    else
      "いらすとや狐.png" # 初期のファイル名
    end
  end

  has_many :user_characters, dependent: :destroy
  has_many :characters, through: :user_characters
  
  after_create :add_default_character

  private

  def add_default_character
    first_char = Character.where("name LIKE ?", "%金宵%").first
    
    if first_char
      self.user_characters.create(character: first_char, evolved: false)
    end
  end
end
