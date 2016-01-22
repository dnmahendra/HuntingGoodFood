require 'pry'
require 'pg'

def run_sql(sql)
	db = PG.connect(dbname: 'goodfoodhunting')
	results = db.exec(sql)
	db.close 
	return results
end


class Dish 

attr_accessor :id, :name, :image_url

	def initialize(id, name, image_url, dish_type_id)
		@id = id,
		@name = name,
		@image_url = image_url,
		@dish_type_id = dish_type_id

	end
end

records = run_sql('select * from dishes;')

dishes = records.map do |record|
	Dish.new(record['id'],record['name'],record['image_url'])
end


binding.pry