    

require 'sinatra/reloader'
require 'pry'


require './db_config'
require './models/dish'
require './models/user'
require './models/like'
require 'pg'
require 'sinatra'

enable :sessions

helpers do
	def logged_in?
		!!current_user
	end

	def current_user
		User.find_by(id: session[:user_id])
	end

	def liked(dish_id)
		if logged_in?
			if Like.find_by(user_id: current_user.id, dish_id: dish_id)
				return "Unlike"
			end
		end
		return "Like"
	end
end



def run_sql(sql)
	db = PG.connect(dbname: 'goodfoodhunting')
	results = db.exec(sql)
	db.close 
	return results
end

get '/' do

	@dish_types = DishType.all

	if params[:dish_type_id] 

		@dishes = Dish.where(dish_type_id: params[:dish_type_id])

	else

		@dishes = Dish.all
	end

	@likes = Like.new

  erb :index
end

#show new dish form
get '/dishes/new' do

	@dish = Dish.new
	@dish_types = DishType.all

erb :new
end


#create a dish
post '/dishes' do


	@dish = Dish.new
	@dish.name = params[:name]
	@dish.image_url = params[:image_url]
	@dish.venue = params[:venue]
	@dish.dish_type_id = params[:dish_type_id]
	if @dish.save
		redirect to '/'
	else
		@dish_types = DishType.all
		erb :new
	end
end

get '/dishes/:id' do

	@dish = Dish.find(params[:id])
	erb :show
end


get '/dishes/:id/edit' do

	@dish_types = DishType.all

	@dish = Dish.find(params[:id])
	erb :edit
end

put '/dishes/:id' do


	dish = Dish.find(params[:id])

	dish.name = params[:name]
	dish.image_url = params[:image_url]
	dish.venue = params[:venue]
	dish.dish_type_id = params[:dish_type_id]

	dish.save
	redirect to "/dishes/#{params[:id]}"
end

delete '/dishes/:id' do

	dish = Dish.find(params[:id])

	dish.destroy

	redirect to '/'

end 

get '/dish_types' do

	@dish_types = DishType.all

	erb :types
end

## Authentication ========================================

#show the form
get '/session/new' do
	erb :login
end


# login
post '/session' do

#search for the user
user = User.find_by(email: params[:email])

#Authenticate 
	if user && user.authenticate(params[:password])
		#create a session
		session[:user_id] = user.id
		session[:user_name] = user.email
		#redirect to somewhere else
		redirect to '/'

	else

	erb :login
	end
end
# logout
delete '/session' do
	session[:user_id] = nil
	redirect to '/session/new'
end



post '/likes/:dish_id' do

	if logged_in?
		@like = Like.new
		@like.user_id = current_user.id
		@like.dish_id = params[:dish_id]
		if @like.save
			redirect to '/'
		end
	else
		redirect to '/session/new'
	end
end

delete '/likes' do
	likes = Like.where(user_id: current_user.id,
	 dish_id: params[:dish_id])

	likes.each do |like|
		like.destroy
	end
	redirect to '/'
end














