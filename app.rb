require './book'
require './person'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    @people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person(age, name = 'Unknown', parent_permission: true)
    person = Person.new(age, name, parent_permission: parent_permission)
    @people << person
    person
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books << book
    book
  end

  def create_rental(person_id, book_title, date)
    person = find_person_by_id(person_id)
    book = find_book_by_title(book_title)

    if person && book
      rental = Rental.new(date, person, book)
      @rentals << rental
      rental
    else
      puts "Person or book not found."
    end
  end

  def list_rentals_for_person(person_id)
    person = find_person_by_id(person_id)

    if person
      rentals = @rentals.select { |rental| rental.person == person }
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book: #{rental.book.title}"
      end
    else
      puts "Person not found."
    end
  end

  private

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
  end

  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end
end
