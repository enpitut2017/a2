class Item < ApplicationRecord

  belongs_to :genre, optional: true
  belongs_to :place, optional: true
  belongs_to :department, optional: true
  has_many :comments

  mount_uploader :image, PictureUploader

	validate :name_error
	validate :place_id_error
  # 画像を必ず必要とするとき
	# validate :image_error
	validate :price_error
	validate :detail_error
	validate :genre_id_error
	validate :student_id_error
	validate :department_id_error

	def name_error
	  #nameが空の時にエラーメッセージを追加する
	  if name.empty?
	    errors[:base] << "名前の欄は空白のまま送信できません"
	  end
	end

	def place_id_error
          #地域が空の時にエラーメッセージを追加する
          if place_id.nil?
            errors[:base] << "地域の欄は空白のまま送信できません"
          end
        end

  # 画像を必ず必要とするとき
	# def image_error
  #         #画像が空の時にエラーメッセージを追加する
  #         if image.file.nil?
  #           errors[:base] << "画像を追加してください"
  #         end
  #       end

	def price_error
          #価格が空の時にエラーメッセージを追加する
          if price.nil?
            errors[:base] << "価格の欄は空白のまま送信できません"
          end
        end

	def detail_error
          #詳細が空の時にエラーメッセージを追加する
          if detail.empty?
            errors[:base] << "詳細の欄は空白のまま送信できません"
          end
        end

	def genre_id_error
          #ジャンルが空の時にエラーメッセージを追加する
          if genre_id.nil?
            errors[:base] << "ジャンルの欄は空白のまま送信できません"
          end
        end

	def student_id_error
          #学籍番号が空の時にエラーメッセージを追加する
          if student_id.nil?
            errors[:base] << "学籍番号の欄は空白のまま送信できません"
          end
        end

	def department_id_error
          #学類が空の時にエラーメッセージを追加する
          if department_id.nil?
            errors[:base] << "学類の欄は空白のまま送信できません"
          end
        end

end
