require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'rental_lister'
require_relative 'rental_creator'
require_relative 'student_creator'
require_relative 'teacher_creator'
require_relative 'book_creator'
require 'json'

class App
  def initialize
    @books = load_books_data.map { |data| create_book_from_data(data) }
    @people = load_people_data
    @rentals = load_rentals_data
  end

  def display_menu
    puts "\nOptions:"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person id'
    puts '7. Quit'
    print 'Enter the option number: '
  end

  def list_books
    puts @books.empty? ? 'No books available.' : "\nList of Books:\n#{books_list}"
  end

  def list_people
    if @people.empty?
      puts 'No people available.'
    else
      puts "\nList of People:"
      @people.each_with_index do |person, index|
        puts "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def list_rentals_for_person_id
    if @people.empty?
      puts 'No people available to list rentals.'
      return
    end

    puts 'Select the person ID to list rentals:'
    list_people
    print 'Enter the person ID: '
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Invalid person ID.'
    else
      person_rentals = @rentals.select { |rental| rental.person.id == person_id }
      if person_rentals.empty?
        puts 'No rentals found for this person.'
      else
        puts "\nRentals for #{person.name}:"
        list_rentals(person_rentals)
      end
    end
  end

  def list_rentals_for_person
    if @people.empty?
      puts 'No people available to list rentals.'
      return
    end

    rental_listings = RentalLister.new(@people, @rentals)
    rental_listings.list_rentals_for_person
  end

  def loaded_people
    if File.exist?('people.json')
      load_people_data
      display_loaded_people
    else
      puts 'No people available.'
    end
  end

  def create_student
    student_creator = StudentCreator.new(@people)
    student_creator.create_student
  end

  def create_teacher
    teacher_creator = TeacherCreator.new(@people)
    teacher_creator.create_teacher
  end

  def create_book
    book_creator = BookCreator.new(@books)
    book_creator.create_book
  end

  def create_rental
    rental_creator = RentalCreator.new(@people, @books, @rentals)
    rental_creator.create_rental
  end

  def exit_app
    puts 'Thank you for using this App.'
    exit
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

  private

  def books_list
    @books.map.with_index { |book, index| "#{index}. Title: \"#{book.title}\", Author: #{book.author}" }.join("\n")
  end

  def people_list
    @people.map.with_index do |person, index|
      "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end.join("\n")
  end

  def load_people_data
    if File.exist?('people.json')
      begin
        existing_data = File.read('people.json')
        @people = JSON.parse(existing_data).map { |data| create_person_from_data(data) }
      rescue JSON::ParserError => e
        puts "Error parsing people.json: #{e.message}"
        @people = []
      end
    else
      @people = []
    end
  end

  def display_people
    puts "\nList of People:"
    @people.each_with_index do |person, index|
      puts "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def display_loaded_people
    puts "\nList of People:"
    @people.each_with_index do |person_data, index|
      person = create_person_from_data(person_data)
      if person
        puts "#{index}. [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{index}. [Invalid Person Data]"
      end
    end
  end

  def create_person_from_data(data)
    if data.is_a?(Hash)
      if data['name'].nil? || data['age'].nil?
        puts "Error: Missing 'name' or 'age' attribute in person data: #{data}"
        return nil
      end
      if data['person'] == 'student'
        Student.new(
          name: data['name'],
          age: data['age'],
          parent_permission: data['parent_permission']
        )
      elsif data['person'] == 'teacher'
        Teacher.new(
          name: data['name'],
          age: data['age'],
          specialization: data['specialization'],
          parent_permission: data['parent_permission']
        )
      else
        Person.new(
          name: data['name'],
          age: data['age'],
          parent_permission: data['parent_permission']
        )
      end
    else
      puts "Error: Invalid data format for person: #{data}"
      nil
    end
  end

  def load_books_data
    if File.exist?('books.json')
      existing_data = File.read('books.json')
      JSON.parse(existing_data)
    else
      []
    end
  end

  def create_book_from_data(data)
    Book.new(data['title'], data['author'])
  end

  def load_rentals_data
    if File.exist?('rentals.json')
      existing_data = JSON.parse(File.read('rentals.json'))
      @rentals = existing_data.map do |rental_data|
        person_data = rental_data['person']
        book_data = rental_data['book']
        person = create_person_from_data(person_data)
        book = create_book_from_data(book_data)
        Rental.new(rental_data['date'], person, book)
      end
    else
      []
    end
  end
end
