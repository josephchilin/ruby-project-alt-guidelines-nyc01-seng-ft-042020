require_relative '../config/environment'
require_relative '../lib/ingredient'
require_relative '../lib/recipe'
require_relative '../lib/recipe_ingredient'

Ingredient.delete_all
Recipe.delete_all
RecipeIngredient.delete_all

r1 = Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
r2 = Recipe.create(name: "Mac & Cheese", instruction: "You make mac & cheese by mixing macaroni and cheese.")
r3 = Recipe.create(name: "Cheeseburger", instruction: "You make a cheeseburger by searing a cheeseburger.")
r4 = Recipe.create(name: "Belgian Waffle", instruction: "You make a waffle in a waffle maker.")
r5 = Recipe.create(name: "Chocolate Chip Waffle", instruction: "You make a waffle in a waffle maker.")

i1 = Ingredient.create(name: "rice")
i2 = Ingredient.create(name: "egg")
i3 = Ingredient.create(name: "garlic")
i4 = Ingredient.create(name: "macaroni")
i5 = Ingredient.create(name: "cheddar cheese")
i6 = Ingredient.create(name: "burger bun")
i7 = Ingredient.create(name: "hamburger patty")
i8 = Ingredient.create(name: "salt")
i9 = Ingredient.create(name: "pepper")
i10 = Ingredient.create(name: "butter")
i11 = Ingredient.create(name: "flour")
i12 = Ingredient.create(name: "sugar")
i13 = Ingredient.create(name: "milk")
i14 = Ingredient.create(name: "vegetable oil")
i15 = Ingredient.create(name: "chocolate chip")

rice1 = RecipeIngredient.create(recipe: r1, ingredient: i1, ingredient_quantity: "32oz")
rice2 = RecipeIngredient.create(recipe: r1, ingredient: i2, ingredient_quantity: "4")
rice3 = RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4 cloves")
rice4 = RecipeIngredient.create(recipe: r1, ingredient: i10, ingredient_quantity: "8 tbsp")
rice5 = RecipeIngredient.create(recipe: r1, ingredient: i8, ingredient_quantity: "pinch")
rice6 = RecipeIngredient.create(recipe: r1, ingredient: i9, ingredient_quantity: "pinch")


mac1 = RecipeIngredient.create(recipe: r2, ingredient: i4, ingredient_quantity: "16oz")
mac2 = RecipeIngredient.create(recipe: r2, ingredient: i5, ingredient_quantity: "8oz")
mac3 = RecipeIngredient.create(recipe: r2, ingredient: i10, ingredient_quantity: "4 tbsp")

burg1 = RecipeIngredient.create(recipe: r3, ingredient: i5, ingredient_quantity: "2 slices")
burg2 = RecipeIngredient.create(recipe: r3, ingredient: i6, ingredient_quantity: "1")
burg3 = RecipeIngredient.create(recipe: r3, ingredient: i7, ingredient_quantity: "1")

waf1 = RecipeIngredient.create(recipe: r4, ingredient: i2, ingredient_quantity: "2")
waf2 = RecipeIngredient.create(recipe: r4, ingredient: i8, ingredient_quantity: "1/4 tsp")
waf3 = RecipeIngredient.create(recipe: r4, ingredient: i11, ingredient_quantity: "2 cups")
waf4 = RecipeIngredient.create(recipe: r4, ingredient: i12, ingredient_quantity: "1 tbsp")
waf5 = RecipeIngredient.create(recipe: r4, ingredient: i13, ingredient_quantity: "1 3/4 cup")
waf6 = RecipeIngredient.create(recipe: r4, ingredient: i14, ingredient_quantity: "1/2 cup")

waf7 = RecipeIngredient.create(recipe: r5, ingredient: i2, ingredient_quantity: "2")
waf8 = RecipeIngredient.create(recipe: r5, ingredient: i8, ingredient_quantity: "1/4 tsp")
waf9 = RecipeIngredient.create(recipe: r5, ingredient: i11, ingredient_quantity: "2 cups")
waf10 = RecipeIngredient.create(recipe: r5, ingredient: i12, ingredient_quantity: "1 tbsp")
waf11 = RecipeIngredient.create(recipe: r5, ingredient: i13, ingredient_quantity: "1 3/4 cup")
waf12 = RecipeIngredient.create(recipe: r5, ingredient: i14, ingredient_quantity: "1/2 cup")
waf13 = RecipeIngredient.create(recipe: r5, ingredient: i15, ingredient_quantity: "1/4 cup")

# def recipe_names
#     Recipe.all.map do |recipe|
#         recipe.name 
#     end
# end
# binding.pry