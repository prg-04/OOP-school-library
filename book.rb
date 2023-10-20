class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

 def to_hash
    {
      'title' => @title,
      'author' => @author,
      'rentals' => @rentals.map(&:to_hash)
    }
  end

  def write_to_json
    write_to_json_file(to_hash, 'books.json')
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
