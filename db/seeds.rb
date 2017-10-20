require "csv"

if File.exist?('db/departments.csv') == true
CSV.foreach('db/departments.csv').each do |row|
  Department.find_or_create_by(:id => row[0], :name => row[1])
end
end

require "csv"

if File.exist?('db/places.csv') == true
CSV.foreach('db/places.csv').each do |row|
  Place.find_or_create_by(:id => row[0], :name => row[1])
end
end

require "csv"

if File.exist?('db/genres.csv') == true
CSV.foreach('db/genres.csv').each do |row|
  Genre.find_or_create_by(:id => row[0], :name => row[1])
end
end
