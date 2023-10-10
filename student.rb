require_relative 'person'

class Student < Person
  def initialize(name, age, classroom)
    @classroom = classroom
    super(name, age)
  end

  def play_hook
    '¯\(ツ)/¯'
  end
end
