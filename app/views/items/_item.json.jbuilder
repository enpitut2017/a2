json.extract! item, :id, :name, :place_id, :image, :price, :detail, :genre_id, :student_id, :department_id, :created_at, :updated_at
json.url item_url(item, format: :json)
