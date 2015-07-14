require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutModules < Neo::Koan
  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(___(NoMethodError)) do
      Nameable.new
    end
  end

  # ------------------------------------------------------------------

  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end

  def test_normal_methods_are_available_in_the_object
    fido = Dog.new
    assert_equal __("WOOF"), fido.bark
  end

  def test_module_methods_are_also_available_in_the_object
    fido = Dog.new
    assert_nothing_raised do # __
      fido.set_name("Rover")
    end
  end

  def test_module_methods_can_affect_instance_variables_in_the_object
    fido = Dog.new
    assert_equal __("Fido"), fido.name
    fido.set_name("Rover")
    assert_equal __("Rover"), fido.name
  end

  def test_classes_can_override_module_methods
    fido = Dog.new
    assert_equal __(:in_object), fido.here
  end
end

#-----------------------------------------------------------------------
#When creating complex objects, we use inheritance
#You should create a complex chair using simple components

class Chair_Components

  module Back
    attr_reader :back_height
    def back_set_height(new_heigth)
      @back_height = new_heigth
    end
  end

  module Seat
    attr_reader :seat_width
    def seat_set_width(new_width)
      @seat_width = new_width
    end
  end

  module Leg
    attr_reader :leg_height  
    def leg_set_height(new_heigth)
      @leg_height = new_heigth
    end   
end

class Chair

  include Back, Seat, Leg   

  def build_chair(leg_h, seat_w, back_h)
    leg_set_height(leg_h)
    seat_set_width(seat_w)
    back_set_height(back_h)  
  end

  def tell_me_your_tall
    @back_height + @leg_height + 1
  end

  def tell_me_your_width
    @seat_width
  end

  def paint_the_chair
    paint_back
    paint_seat
    paint_legs
  end

  def paint_back
    @back_height.times {puts "*"}
  end

  def paint_seat
    puts "*" * @seat_width
  end

  def paint_legs
    
    #build a line    
    @leg_height.times {puts ('*'.ljust @seat_width-1) << "*"}    
  end
end

class Testing_Chair
  #this new chair's measure are back = 5, seat = 9, leg = 6
  #and its tall = 12
  my_chair = Chair.new
  my_chair.build_chair(6,9,5)
  my_chair.paint_the_chair
  my_chair.tell_me_your_tall

  def test_total_height_is_the_sum_of_the_height_of_the_objects
    assert_equal __(12), my_chair.tell_me_your_tall
  end

  def test_total_width_equals_the_width_of_the_seat
    assert_equal __(9), my_chair.tell_me_your_width
  end

  #create your chair which total heigth = 10 and total width = 7
  def test_creating_your_own_chair
    your_chair = Chair.new
    your_chair.build_chair(__, __, __)
    your_chair.paint_the_chair

    assert_equal 10, your_chair.tell_me_your_tall

    assert_equal 7, your_chair.tell_me_your_width
  end

  def test_creating_other_chair
    #create a new chair which total height and total width are the same
    other_chair = Chair.new
    
    #write here your code

    assert_equal other_chair.tell_me_your_width = other_chair.tell_me_your_tall
  end

  def test_should_use_all_arguments    
    assert_raise (__(ArgumenError)) do
      error_chair = Chair.new
      error_chair (5,5)
   end
   
  end  
 end
end
