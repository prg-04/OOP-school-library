require_relative 'person'
require_relative 'file_handler'

class Student < Person
  include JsonFileHandler
  def initialize(age:, name: 'Unknown', parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = []
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_hash
    {
      'person' => 'student',
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
    }
  end

  def write_to_json
    write_person_to_json(to_hash)
  end

  private

  def write_person_to_json(data)
    if File.exist?('people.json')
      existing_data = File.read('people.json')
      people_data = JSON.parse(existing_data)
    else
      people_data = []
    end

    people_data << data

    File.open('people.json', 'w') do |file|
      file.puts JSON.pretty_generate(people_data)
    end
  end
end
