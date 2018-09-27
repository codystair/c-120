class RecipeBook
  attr_accessor :receipes = [#specific recipe objects like maincourse... dessert ..]
end

class Recipe
  include Conversion
  attr_accessor :ingredients = [ingredient objects]
  #some generic recipe characteristics

end

class StartRecipe < Recipe
  # some more specific details
end

class MainCourseRecipe < Recipe
  # some more specific details
end

class DessertRecipe < Recipe
  # some more specific details
end

class Ingredient
  include Conversion
end

module Conversion
  # containing
    # methods for how to handle single Ingredient and cook recipe(a package of Ingredients)
    # methods for measure the state of Ingredient and diff recipes
end
