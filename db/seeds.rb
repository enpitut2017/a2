require "csv"

if File.exist?('db/departments.csv') == true
CSV.foreach('db/departments.csv').each do |row|
  Department.find_or_create_by(:name => row[0])
end
end

require "csv"

if File.exist?('db/places.csv') == true
CSV.foreach('db/places.csv').each do |row|
  Place.find_or_create_by(:name => row[0])
end
end

require "csv"

if File.exist?('db/genres.csv') == true
CSV.foreach('db/genres.csv').each do |row|
  Genre.find_or_create_by(:name => row[0])
end
end



#====サンプルデータ==================
Item.create(
  :name => "線形代数",
  :place_id => "2",
  :image => "linear.png",
  :price => "990",
  :detail => "線形代数の教科書です。大事なところには線が引いてあります。

  誰か買ってくれませんか？",
  :genre_id => "4",
  :student_id => "201511234",
  :department_id => "9"
)

Item.create(
  :name => "木の机",
  :place_id => "5",
  :image => "table.png",
  :price => "1300",
  :detail => "引っ越すので机あげます。
  車で家まで運びます！",
  :genre_id => "1",
  :student_id => "201712345",
  :department_id => "4"
)

Item.create(
  :name => "冷蔵庫",
  :place_id => "8",
  :image => "reizouko.png",
  :price => "380",
  :detail => "冷蔵庫もういらないのですが、車がないのでご了承ください。",
  :genre_id => "2",
  :student_id => "201258483",
  :department_id => "18"
)

Item.create(
  :name => "赤い自転車",
  :place_id => "9",
  :image => "bike.png",
  :price => "1480",
  :detail => "そんなにエクストリームしてません",
  :genre_id => "5",
  :student_id => "201712345",
  :department_id => "20"
)
