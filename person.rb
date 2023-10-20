require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  def initialize(parent_permission: true, name: 'Unknown', age: nil)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    rental = Rental.new(date,book)
    @rentals << rental
    rental
  end

  private

  def of_age?
    @age.to_i >= 18
  end
  def write_person_to_json(data)
  if File.exist?('people.json')
    existing_data = File.read('people.json')
    people_data = JSON.parse(existing_data)
  else
    people_data = []
  end

  people_data << data

  begin
    File.open('people.json', 'w') do |file|
      file.puts JSON.pretty_generate(people_data)
    end
    puts 'Data written to people.json successfully.'
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end
end

end
