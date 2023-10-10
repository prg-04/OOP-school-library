require_relative 'person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    @classroom = classroom
    super(name, age, parent_permission: parent_permission)
  end

  def play_hook
    '¯\(ツ)/¯'
  end
end
