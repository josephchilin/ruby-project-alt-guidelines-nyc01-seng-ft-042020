Ingredient.delete_all
Recipe.delete_all
RecipeIngredient.delete_all

r1 = Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
r2 = Recipe.create(name: "Mac & Cheese", instruction: "You make mac & cheese by mixing macaroni and cheese.")
r3 = Recipe.create(name: "Hamburger", instruction: "You make a hamburger by searing a hamburger.")

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

rice1 = RecipeIngredient.create(recipe: r1, ingredient: i1, ingredient_quantity: "32oz")
rice2 = RecipeIngredient.create(recipe: r1, ingredient: i2, ingredient_quantity: "4")
rice3 = RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4")

mac1 = RecipeIngredient.create(recipe: r2, ingredient: i4, ingredient_quantity: "16oz")
mac2 = RecipeIngredient.create(recipe: r2, ingredient: i5, ingredient_quantity: "8oz")

# binding.pry