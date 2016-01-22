require './db_config'
require './models/dish'
require './models/user'
require './models/like'

DishType.delete.all
Dish.delete.all

DishType.create(name: 'snack')
DishType.create(name: 'dinner')

lunch = DishType.create(name: 'brunch')

Dish.create(name: 'cakepudding', dish_type_id: lunch.id)