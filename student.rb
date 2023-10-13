require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, _classroom, name = 'Unknown', parent_permission: true)
    super(name, age, parent_permission)
    @classroom = nil
  end

  def play_hook
    '¯\(ツ)/¯'
  end

  def join_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end
end
