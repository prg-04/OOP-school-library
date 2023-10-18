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

class App
  def initialize
    @books = []
    @people = []
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
    # rubocop:disable Style/StringConcatenation
    puts @people.empty? ? 'No people available.' : "\nList of People:\n" + people_list
    # rubocop:enable Style/StringConcatenation
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
    rental_creator = RentalCreator.new(@people, @books)
    rental_creator.create_rental
  end

  def list_rentals_for_person
    rental_listings = RentalLister.new(@people)
    rental_listings.list_rentals_for_person
  end

  def exit_app
    puts 'Thank you for using this App.'
    exit
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
end
