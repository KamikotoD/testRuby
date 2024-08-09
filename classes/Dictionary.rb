require 'fileutils'

class Dictionary
  attr_reader :dictionary

  def self.get_dictionary_from_file(directory_path, file_name)
    new(reader_dictionary_from_file(directory_path, file_name))
  end

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def save_dictionary_to_file(directory_path, file_name)
    existing_dict = self.class.reader_dictionary_from_file(directory_path, file_name)
    combined_dict = (existing_dict + @dictionary).uniq
    TypeReaderFile.marshal_write(File.join(directory_path, file_name), combined_dict)
  end

  private

  def self.reader_dictionary_from_file(directory_path, file_name)
    FileUtils.mkdir_p(directory_path) unless Dir.exist?(directory_path)
    file_path = File.join(directory_path, file_name)
    if file_path && File.exist?(file_path + ".marshal")
      return TypeReaderFile.marshal_read(file_path)
    else
      []
    end
  end
end
