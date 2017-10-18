require "csv"

if File.exist?('db/departments.csv') == true
CSV.foreach('db/departments.csv').each do |row|
  Department.find_or_create_by(:id => row[0], :name => row[1])
end
end
