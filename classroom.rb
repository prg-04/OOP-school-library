class Classroom
  attr_accessor :label

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student
    @student << student
    student.classroom = self
  end
end
