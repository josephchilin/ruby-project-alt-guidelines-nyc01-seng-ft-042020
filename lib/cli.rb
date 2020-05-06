require_relative '../config/environment'
require_relative '../lib/ingredient'
require_relative '../lib/recipe'
require_relative '../lib/recipe_ingredient'

# Recipe (name, instruction)
# RecipeIngredient (recipe_id, ingredient_id, ingredient_quantity)
# Ingredient (name)

# TO DO 

# MVP
# make edit recipe based off add new recipe
# refactor all tty prompts

# As a user, I want to add a new recipe. (create) DONE
# As a user, I want to read recipes. (read) DONE
# As a user, I want to update my recipe. (update)
# As a user, I want to delete my recipe. (delete) DONE

# EXTRA
# enable ingredient quantity
# make search by name
# make search by ingredient

class CommandLineInterface

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        puts "Welcome to Recipe Finder, your home for delicious food!"
    end

#====NAVIGATION

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

#===RECIPE PAGE
    def recipe_page(recipe)
        recipe_name(recipe)
        recipe_ingredients(recipe)
        recipe_instruction(recipe)
        #name => make recipe_name method
        #ingredients => make display all ingredients method
                # iterate through Recipe.WHATEVER.ingredients
        #instructions
                    # Recipe.WHATEVER.instruction
    end

#===RECIPE PAGE HELPERS
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
            puts ingredient_name.titleize
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


#===INGREDIENTS HELPER METHODS
    def all_ingredients
        Ingredient.all.map do |ingredient|
            ingredient.name 
        end
    end

    def ingredient_instance(ingredient_name)
        Ingredient.find_by name: ingredient_name
    end

#===MENU OPTIONS======

#===VIEW RECIPES======
    def view_recipes
        prompt = TTY::Prompt.new
# @recipe_choice carries name string of recipe chosen
        @recipe_choice = prompt.select("Choose Your recipe", all_recipes)
    #---recipe info-----
        recipe_page(@recipe_choice)
        # binding.pry
        puts "\n"
        nav_menu
    end

# Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
# Ingredient.create(name: "rice")
# RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4")
    
#===ADD RECIPE===
    def add_recipe
        prompt = TTY::Prompt.new
        recipe_name = prompt.ask("What is the name of your recipe?")
        recipe_name = recipe_name.titleize
        Recipe.create(name: recipe_name, instruction: nil)
        add_ingredient
        recipe_instruction = prompt.ask("How do you cook #{recipe_name}?")
        Recipe.last.update(name: recipe_name, instruction: recipe_instruction)
# binding.pry
        puts "Thanks for submitting a recipe for #{recipe_name}!"
        puts "\n"
    @recipe_choice = recipe_name
        nav_menu
    end

# NEED ARRAY OF ALL INGREDIENT NAMES TO REFERENCE
# SHOVEL INGREDIENT OBJECT INTO LAST RECIPE OBJECT

    def ingredient_logic(ingredient)
        if all_ingredients.include?(ingredient)
            new_recipe_ingredient = ingredient_instance(ingredient)
            Recipe.last.ingredients << new_recipe_ingredient
        else
            new_recipe_ingredient = Ingredient.create(name: ingredient)
            Recipe.last.ingredients << new_recipe_ingredient
        end
    end
#===ADD INGREDIENT HELPER==========
    def add_ingredient
        prompt = TTY::Prompt.new
        ingredient = prompt.ask("What is your recipe's first ingredient?")

        ingredient_logic(ingredient)

    # build more ingredients loop
        loop do
         more_ingredients = prompt.yes?("Does your recipe have more ingredients?")
        
            if more_ingredients #=> true
                ingredient = prompt.ask("What is your recipe's next ingredient?")

                ingredient_logic(ingredient)
            else
                break
            end
        end
    end

#===EDIT HELPER METHODS====
    def edit_menu
        prompt = TTY::Prompt.new
        prompt.select("What do you want to edit?") do |menu|
            menu.choice "Edit name", -> {edit_name}
            menu.choice "Edit ingredients", -> {edit_ingredients}
            menu.choice "Edit instruction", -> {edit_instruction}
            menu.choice "Back to menu", -> {nav_menu}
        end
    end

    def edit_name
        new_name = @prompt.ask("What is the new recipe name?")
        new_name = new_name.titleize
        current_recipe = recipe_instance(@recipe_choice)
        current_recipe.update(name: new_name)
        puts "Your recipe is now called #{new_name}!"
        # binding.pry
        edit_menu
    end

    def edit_ingredients
        puts "EDIT INGREDIENTS"
        edit_menu
    end

    def edit_instruction
        puts "EDIT INSTRUCTION"
        edit_menu
    end
#===EDIT RECIPE========
    def edit_recipe
        prompt = TTY::Prompt.new
        edit_rec = prompt.yes?("Are you sure you want to edit #{@recipe_choice}?")
    
        if edit_rec #=> true
            edit_menu
        else
            nav_menu
        end

    # .update
    end

#===DELETE RECIPE======
    def delete_recipe
        prompt = TTY::Prompt.new
        current_recipe = recipe_instance(@recipe_choice)
        # binding.pry
        delete_rec = prompt.yes?("Are you sure you want to delete #{@recipe_choice}?")

        if delete_rec # => true
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

#===QUIT=======
    def quit_program
        puts "Thanks for using me!"
        exit
    end
# binding.pry
end
