require './book'
require './person'

class Rental
  attr_accessor :date, :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
  end

  def to_hash
    {
      'date' => @date,
      'person' => @person.to_hash,
      'book' => @book.to_hash
    }
  end

  def write_to_json
    write_to_json_file(to_hash, 'rentals.json')
  end

  private

  def write_to_json_file(data, filename)
    if File.exist?(filename)
      existing_data = File.read(filename)
      items_data = JSON.parse(existing_data)
    else
      items_data = []
    end

    items_data << data

    File.open(filename, 'w') do |file|
      file.puts JSON.pretty_generate(items_data)
    end
  end
end
