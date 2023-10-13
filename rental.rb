require './book'

class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
    person.add_rental(self)
    book.add_rental(self)
  end
end
