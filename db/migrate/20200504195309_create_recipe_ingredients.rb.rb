class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id 
      t.integer :ingredient_id
      t.string :ingredient_quantity
    end
  end
end
