class DishesController < ApplicationController
  get '/dishes' do
    dishes = Dish.all
    dishes.to_json(
      only: [:id, :name, :description, :price], 
      include: {
        allergies: { only: [:id, :name] },
        ingredients: { 
          only: [:dish_id, :allergy_id, :name, :is_avoidable]
        }
      }
    )
  end

  get '/dishes/:id' do
    dish = Dish.find(params[:id])
    dish.to_json(
      only: [:id, :name, :description, :price], 
      include: {
        allergies: { only: :name },
        ingredients: { 
          only: [:dish_id, :allergy_id, :name, :is_avoidable]
        }
      }
    )
  end

  post '/dishes' do
    # binding.pry

    dish = Dish.create(
      name: params[:name], 
      description: params[:description], 
      price: params[:price]
    )
    dish.to_json

    # redirect "/dishes/${dish.id}"
  end

  patch '/dishes/:id' do
    dish = Dish.find(params[:id])
    attrs_to_update = params.select do |key, value|
      [ "name", "description", "price" ].include?(key)
    end
    dish.update(attrs_to_update)
    dish.to_json
  end
  


  delete '/dishes/:id' do
    dish = Dish.find(params[:id])
    dish.destroy
    dish.to_json
  end

end