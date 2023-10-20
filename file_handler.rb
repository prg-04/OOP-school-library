module JsonFileHandler
  def write_to_json_file(filename, data)
    if File.exist?(filename)
      existing_data = File.read(filename)
      json_data = JSON.parse(existing_data)
    else
      json_data = []
    end

    json_data << data

    begin
      File.open(filename, 'w') do |file|
        file.puts JSON.pretty_generate(json_data)
      end
      puts "Data written to #{filename} successfully."
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end
end