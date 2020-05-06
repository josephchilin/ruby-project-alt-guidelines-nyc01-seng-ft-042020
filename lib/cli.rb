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
            menu.choice "Exit program", -> {quit_program}
        end
    end

    def nav_menu
        prompt = TTY::Prompt.new
        prompt.select("What would you like to do now?") do |menu|
            menu.choice "View recipes", -> {view_recipes}
            menu.choice "Add recipe", -> {add_recipe}
            menu.choice "Edit recipe", -> {edit_recipe}
            menu.choice "Delete recipe", -> {delete_recipe}
            menu.choice "Exit program", -> {quit_program}
        end
    end

# TO DO 
# make add new recipe
# make edit recipe based off add new recipe

    def recipe_page(recipe)
        recipe_name(recipe)
        recipe_ingredients(recipe)
        recipe_instruction(recipe)
        #name => make recipe_name method
        #ingredients => make display all ingredients method
                # iterate through Recipe.WHATEVER.ingredients
        # puts "Instruction: #{}"
        #instructions
                    # Recipe.WHATEVER.instruction
    end

#---RECIPE PAGE HELPERS
    def recipe_instance(recipe_name)
        Recipe.find_by name: recipe_name
    end

    def recipe_name(name)
        puts "Recipe: #{name}"
    end

    def recipe_ingredients(name)
        recipe = recipe_instance(name)
        # recipe.ingredients.first.name
        list = recipe.ingredients.map {|ingredient| ingredient.name}
        puts "Ingredients:"
        list.each do |ingredient_name|
            puts ingredient_name.capitalize
        end

        # binding.pry
    end

    def recipe_instruction(name)
        # recipe_object = Recipe.find_by name: name
        recipe = recipe_instance(name)
        instruction = recipe.instruction
        puts "Instructions: #{instruction}"
        # => returns instruction for given recipe string name
    end

    def all_recipes
        Recipe.all.map do |recipe|
            recipe.name 
        end
    end


#---INGREDIENTS HELPER METHODS
    def all_ingredients
        Ingredient.all.map do |ingredient|
            ingredient.name 
        end
    end

    def ingredient_instance(ingredient_name)
        Ingredient.find_by name: ingredient_name
    end

#---MENU OPTIONS
    def view_recipes
        prompt = TTY::Prompt.new
        @recipe_choice = prompt.select("Choose Your recipe", all_recipes)
    #---recipe info-----
        recipe_page(@recipe_choice)
        # binding.pry
        puts "\n"
        nav_menu
    end

    def add_recipe
        prompt = TTY::Prompt.new
        recipe_name = prompt.ask("What is the name of your recipe?")
        Recipe.create(name: recipe_name, instruction: nil)
        add_ingredient
        recipe_instruction = prompt.ask("How do you cook #{recipe_name}?")
        Recipe.last.update(name: recipe_name, instruction: recipe_instruction)
binding.pry
        puts "Thanks for submitting a recipe for #{recipe_name}!"
        puts "\n"

        nav_menu
        # print "ADD RECIPE"
        # Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
        # Ingredient.create(name: "rice")
        # RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4")
    end
# NEED ARRAY OF ALL INGREDIENT NAMES TO REFERENCE
# SHOVEL INGREDIENT OBJECT INTO LAST RECIPE OBJECT
    def add_ingredient
        prompt = TTY::Prompt.new
        ingredient = prompt.ask("What is your recipe's first ingredient?")
        
        if all_ingredients.include?(ingredient)
            new_recipe_ingredient = ingredient_instance(ingredient)
            Recipe.last.ingredients << new_recipe_ingredient
        else
            new_recipe_ingredient =  Ingredient.create(name: ingredient)
            Recipe.last.ingredients << new_recipe_ingredient
        end

    # build more ingredients loop

    end
    # Recipe.ingredients = 
    # def add_ingredient(new_ingredient)
    #     Ingredient.new 
    # end


    def edit_recipe
        "EDIT RECIPE"
        # .update
    end

    def delete_recipe
        prompt = TTY::Prompt.new
        current_recipe = recipe_instance(@recipe_choice)
        # binding.pry
        delete_rec = prompt.yes?("Are you sure you want to delete #{@recipe_choice}?")
        # => true
        if delete_rec
            puts "Recipe: #{@recipe_choice} has been deleted."
            puts "\n"
            current_recipe.delete
            main_menu
        else
            puts "Recipe: #{@recipe_choice} has not been deleted."
            puts "\n"
            nav_menu
        end
    end

    def quit_program
        exit
    end
# binding.pry
end
