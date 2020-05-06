require_relative '../config/environment'
require_relative '../lib/ingredient'
require_relative '../lib/recipe'
require_relative '../lib/recipe_ingredient'

# As a user, I want to add a new recipe. (create)
# As a user, I want to read recipes. (read)
# As a user, I want to update my recipe. (update)
# As a user, I want to delete my recipe. (delete)

# Recipe (name, instruction)
# RecipeIngredient (recipe_id, ingredient_id, ingredient_quantity)
# Ingredient (name)
# class CommandLineInterface

    def greet
        puts "Welcome to Recipe Finder, your home for delicious food!"
    end




# Starting menu navigation

def main_menu
    prompt = TTY::Prompt.new

    menu_options = {
        "Find recipes" => find_recipe,
        "Add recipe" => add_recipe
    }

    menu_choice = prompt.select("What would you like to do?", [
        "Find recipes",
        "Add recipe"
    ]) 
    
        # do |menu|
        # menu.choice "Find recipes", 1
        # menu.choice "Add recipe", 2
        # menu.choice "Update recipe", 3
        # menu.choice "Delete recipe", 4

    menu_options[menu_choice]
    # end

end

def find_recipe
    "FIND RECIPES"
end

def add_recipe
    "ADD RECIPE"
end
# main_menu
binding.pry