require_relative '../config/environment'
require_relative '../lib/ingredient'
require_relative '../lib/recipe'
require_relative '../lib/recipe_ingredient'

# As a user, I want to add a new recipe. (create)
# As a user, I want to read recipes. (read) DONE
# As a user, I want to update my recipe. (update)
# As a user, I want to delete my recipe. (delete) DONE

# Recipe (name, instruction)
# RecipeIngredient (recipe_id, ingredient_id, ingredient_quantity)
# Ingredient (name)
class CommandLineInterface

    def greet
        puts "Welcome to Recipe Finder, your home for delicious food!"
    end

# Starting menu navigation

def main_menu
    prompt = TTY::Prompt.new
# hash as nav to link to other methods
    # menu_options = {
    #     "View recipes" => view_recipes,
    #     "Add recipe" => add_recipe
    # }

# tty menu
    # menu_choice = prompt.select("What would you like to do?", [
    #     "View recipes",
    #     "Add recipe"
    # ]) 

# use return value of tty menu to trigger value from hash key
    # menu_options[menu_choice]
  
# refactored menu
    prompt.select("What would you like to do?") do |menu|
        menu.choice "View recipes", -> {view_recipes}
        menu.choice "Add recipe", -> {add_recipe}
        # menu.choice "Update recipe", 3
        # menu.choice "Delete recipe", 4
    end
end

def nav_menu
    prompt = TTY::Prompt.new
    prompt.select("What would you like to do now?") do |menu|
        menu.choice "Edit recipe", -> {edit_recipe}
        menu.choice "Delete recipe", -> {delete_recipe}
        menu.choice "Return to main menu", -> {main_menu}
    end
end
# find recipe => view recipe => edit or delete recipe or return to main menu

# TO DO 
# make formatted recipe page
    # make ingredients method
# make add new recipe
# make edit recipe based off add new recipe

def recipe_page(recipe)
    puts "Recipe: #{recipe}"
    puts "Ingredients: "
    #name => make recipe_name method
    #ingredients => make display all ingredients method
               # iterate through Recipe.WHATEVER.ingredients
    # puts "Instruction: #{}"
    #instructions
                # Recipe.WHATEVER.instruction
    #edit => make edit helper method
    #delete => make delete helper method
    #back to main menu call main_menu method

end

def recipe_name(name)
    puts "Recipe: #{name}"
end

def recipe_instruction(name)
    recipe_object = Recipe.find_by name: name
    instruction = recipe_object.instruction
    puts "Instructions: #{instruction}"
    # => returns instruction for given recipe string name
end

def all_recipes
    Recipe.all.map do |recipe|
        recipe.name 
    end
end

def view_recipes
    prompt = TTY::Prompt.new
    @recipe_choice = prompt.select("Choose Your recipe", all_recipes)
#---recipe info-----
    recipe_name(@recipe_choice)
    recipe_instruction(@recipe_choice)
    # binding.pry
    puts "\n"
    nav_menu
end

def add_recipe
    print "ADD RECIPE"
    # Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
    # Ingredient.create(name: "rice")
    # RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4")
end

def edit_recipe
    "EDIT RECIPE"
end

def delete_recipe
    prompt = TTY::Prompt.new
    current_recipe = Recipe.find_by name: @recipe_choice
    # binding.pry
    delete_rec = prompt.yes?("Are you sure you want to delete #{@recipe_choice}?")
    # => true
    if delete_rec
        puts "Recipe: #{@recipe_choice} has been deleted."
        current_recipe.delete
        main_menu

    else
        puts "Recipe: #{@recipe_choice} has not been deleted."

        nav_menu
    end

end

# binding.pry
end
