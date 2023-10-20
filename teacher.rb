require_relative 'person'

class Teacher < Person
  def initialize(age:, specialization:, name: 'Unknown', parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def to_hash
    {
      'person' => 'teacher',
      'name' => @name,
      'age' => @age,
      'specialization' => @specialization,
      'parent_permission' => @parent_permission,
    }
  end

  def write_to_json
    write_person_to_json(to_hash)
  end

  def can_use_services?
    true
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
