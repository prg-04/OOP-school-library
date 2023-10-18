class StudentCreator
  def initialize(people)
    @people = people
  end

  def create_student
    print "Enter the student's age: "
    age = gets.chomp.to_i
    print "Enter the student's name: "
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission_input = gets.chomp.downcase
    parent_permission = %w[y yes].include?(parent_permission_input)
    student = Student.new(name: name, age: age, parent_permission: parent_permission)
    @people << student
    puts "Student created successfully! (ID: #{student.id})"
  end
end
