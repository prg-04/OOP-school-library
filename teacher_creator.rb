class TeacherCreator
  def initialize(people)
    @people = people
  end

  def create_teacher
    print "Enter the teacher's age: "
    age = gets.chomp.to_i
    print "Enter the teacher's name: "
    name = gets.chomp
    print "Enter the teacher's specialization: "
    specialization = gets.chomp
    teacher = Teacher.new(age: age, specialization: specialization, name: name)
    @people << teacher
    puts "Teacher created successfully! (ID: #{teacher.id})"
  end
end
