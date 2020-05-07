require_relative '../config/environment'
require_relative '../lib/ingredient'
require_relative '../lib/recipe'
require_relative '../lib/recipe_ingredient'

# TO DO 

# MVP
# As a user, I want to add a new recipe. (create) DONE
# As a user, I want to read recipes. (read) DONE
# As a user, I want to update my recipe. (update) DONE
# As a user, I want to delete my recipe. (delete) DONE

# EXTRA
# enable ingredient quantity functionality
# make search by name
# make search by ingredient

#=============================================================================================
class CommandLineInterface

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        puts "Welcome to Recipe Finder, your home for delicious food!"
    end

#====NAVIGATION===============================================================================
    def main_menu
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
        @prompt.select("What would you like to do?") do |menu|
            menu.choice "View recipes", -> {view_recipes}
            menu.choice "Add recipe", -> {add_recipe}
            menu.choice "Exit program", -> {quit_program}
        end
    end

    def nav_menu
        @prompt.select("What would you like to do now?") do |menu|
            menu.choice "View recipes", -> {view_recipes}
            menu.choice "Add recipe", -> {add_recipe}
            menu.choice "Edit recipe", -> {edit_recipe}
            menu.choice "Delete recipe", -> {delete_recipe}
            menu.choice "Exit program", -> {quit_program}
        end
    end

#===RECIPE PAGE===============================================================================
    def recipe_page(recipe)
        puts "Recipe: #{recipe}"
        recipe_ingredients(recipe)
        recipe_instruction(recipe)
        #ingredients => make display all ingredients method
                # iterate through Recipe.WHATEVER.ingredients
        #instructions
                    # Recipe.WHATEVER.instruction
    end

#===RECIPE PAGE HELPERS=======================================================================
    #FINDS RECIPE INSTANCE OBJECT BY NAME STRING OF RECIPE
    def recipe_instance(recipe_name) 
        Recipe.find_by name: recipe_name
    end

    def recipe_ingredients(name)
        recipe = recipe_instance(name)
        # recipe.ingredients.first.name
        list = recipe.ingredients.map {|ingredient| ingredient.name}
        puts "Ingredients:"
        list.each do |ingredient_name|
            puts ingredient_name.downcase.titleize
        end

        # binding.pry
    end

    def recipe_instruction(name)
        # recipe_object = Recipe.find_by name: name
        recipe = recipe_instance(name)
        instruction = recipe.instruction
        puts "Instructions: #{instruction}"
        instruction
        # => returns instruction for given recipe string name
    end

    def all_recipes
        Recipe.all.map do |recipe|
            recipe.name 
        end
    end


#===INGREDIENTS HELPERS=======================================================================
    def all_ingredients
        Ingredient.all.map do |ingredient|
            ingredient.name 
        end
    end

    #FINDS INGREDIENT INSTANCE OBJECT BY NAME STRING OF INGREDIENT
    def ingredient_instance(ingredient_name) 
        Ingredient.find_by name: ingredient_name
    end

#===MENU OPTIONS==============================================================================
# Recipe (name, instruction)
# RecipeIngredient (recipe_id, ingredient_id, ingredient_quantity)
# Ingredient (name)

# Recipe.create(name: "Fried Rice", instruction: "You make fried rice by frying rice.")
# RecipeIngredient.create(recipe: r1, ingredient: i3, ingredient_quantity: "4")
# Ingredient.create(name: "rice")

#===VIEW RECIPES==============================================================================
    def view_recipes
# @recipe_choice holds a string of the chosen recipe's name
        @recipe_choice = @prompt.select("Choose your recipe", all_recipes)
        recipe_page(@recipe_choice)
# @current_recipe holds the instance object of currently selected recipe
        @current_recipe = recipe_instance(@recipe_choice) 
        # binding.pry
        puts "\n"
        nav_menu
    end

#===ADD RECIPE================================================================================
    def add_recipe
        recipe_name = @prompt.ask("What is the name of your recipe?")
        # binding.pry
        recipe_name = recipe_name.downcase.titleize
        Recipe.create(name: recipe_name, instruction: nil)

        add_ingredient
        
        recipe_instruction = @prompt.ask("How do you cook #{recipe_name}?")
        Recipe.last.update(name: recipe_name, instruction: recipe_instruction)
# binding.pry
        puts "Thanks for submitting a recipe for #{recipe_name}!"
        puts "\n"
        @recipe_choice = recipe_name #included for edge nav name display case
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
#===ADD INGREDIENT HELPERS=====================================================================
    def add_ingredient
        ingredient = @prompt.ask("What is your recipe's first ingredient?")

        ingredient_logic(ingredient)

    # build more ingredients loop
        loop do
         more_ingredients = @prompt.yes?("Does your recipe have more ingredients?")
        
            if more_ingredients #=> true
                ingredient = @prompt.ask("What is your recipe's next ingredient?")

                ingredient_logic(ingredient)
            else
                break
            end
        end
    end

#===EDIT RECIPE HELPERS========================================================================
    def edit_menu
        @prompt.select("What do you want to edit?") do |menu|
            menu.choice "Edit name", -> {edit_name}
            menu.choice "Edit ingredients", -> {edit_ingredients}
            menu.choice "Edit instructions", -> {edit_instruction}
            menu.choice "Back to menu", -> {nav_menu}
        end
    end

    def edit_name
        new_name = @prompt.ask("What is the new recipe name?")
        new_name = new_name.downcase.titleize
        puts "Your recipe is now called #{new_name}!"
                # binding.pry
        @current_recipe.update(name: new_name)

        edit_menu
    end

# add or remove ingredients?
# if add, shovel new ingredient into recipe object
# if remove, show menu of ingredients
#       delete ingredient confirmation
#       delete ingredient
#       
    def edit_ingredients
        @prompt.select("Do you want to add or delete ingredients?") do |menu|
            menu.choice "Add ingredient(s)", -> {add_ingredients}
            menu.choice "Delete ingredient(s)", -> {delete_ingredients}
            menu.choice "Back to menu", -> {nav_menu}
        end
    end

    def add_ingredients
        add_new = @prompt.ask("What ingredient would you like to add to this recipe?")

        if all_ingredients.include?(add_new)
            new_recipe_ingredient = ingredient_instance(add_new)
            @current_recipe.ingredients << new_recipe_ingredient
        else
            new_recipe_ingredient = Ingredient.create(name: add_new)
            @current_recipe.ingredients << new_recipe_ingredient
        end

        add_new = add_new.downcase.titleize
        
        puts "#{add_new} has been added to this recipe!"

        edit_menu
    end

    def delete_ingredients
        all_recipe_ingredients = recipe_ingredients(@recipe_choice)
   
        delete_choice = @prompt.select("Choose an ingredient to delete", all_recipe_ingredients)
        current_ingredient = ingredient_instance(delete_choice)
        delete_choice = delete_choice.downcase.titleize
        
        puts "#{delete_choice} has been deleted."

        @current_recipe.ingredients.delete(current_ingredient)

        # binding.pry
        edit_menu
    end

    def edit_instruction
        new_instruction = @prompt.ask("What are the recipe's new instructions?")
        @current_recipe.update(instruction: new_instruction)
        puts "Your recipe's instructions have been updated!"
        edit_menu
    end
#===EDIT RECIPE================================================================================
    def edit_recipe
        edit_rec = @prompt.yes?("Are you sure you want to edit #{@recipe_choice}?")
    
        if edit_rec #=> true
            edit_menu
        else
            nav_menu
        end
    end

    # def edit_more
    #     edit_rec = @prompt.yes?("Do you have more edits to #{@recipe_choice}?")
    
    #     if edit_rec #=> true
    #         edit_menu
    #     else
    #         nav_menu
    #     end
    # end
#===DELETE RECIPE==============================================================================
    def delete_recipe
        # binding.pry
        delete_rec = @prompt.yes?("Are you sure you want to delete #{@recipe_choice}?")

        if delete_rec # => true
            puts "Recipe: #{@recipe_choice} has been deleted."
            puts "\n"
            @current_recipe.delete
            main_menu
        else
            puts "Recipe: #{@recipe_choice} has not been deleted."
            puts "\n"
            nav_menu
        end
    end

#===QUIT=======================================================================================
    def quit_program
        puts "Thanks for using me!"
        exit
    end
# binding.pry
end
