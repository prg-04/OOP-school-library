require './nameable'

class Person < Nameable
  attr_accessor :name, :age, :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    super
  end

  def can_use_services?
    @parent_permission || of_age?(@age)
  end

  def correct_name
    @name
  end

  private

  def of_age?(age)
    age >= 18
  end
end
