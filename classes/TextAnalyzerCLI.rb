require 'fileutils'
require_relative 'Dictionary'
require_relative 'ReaderTextWordCollectionFile'
require_relative 'TextWordCollection'
require_relative 'TypeReaderFile'
require_relative 'WriterTextWordCollectionInFile'

class TextAnalyzerCLI
  def initialize
    @dictionary_dir = './dictionaries'
    @collection_dir = './collections'
    @exceptions_file = 'exceptions.txt'
    FileUtils.mkdir_p(@dictionary_dir)
    FileUtils.mkdir_p(@collection_dir)
  end

  def start
    loop do
      print_main_menu
      choice = gets.chomp.downcase

      case choice
      when '1'
        save_text
      when '2'
        compare_collections_with_dictionary
      when '3'
        load_existing_collections
      when '4'
        exit_program
      else
        puts "Invalid choice. Please select 1, 2, 3, or 4."
      end
    end
  end

  private

  def print_main_menu
    puts "\n==== Text Analyzer ===="
    puts "1. Save new text"
    puts "2. Compare collections with your dictionary"
    puts "3. Load existing collections"
    puts "4. Exit"
    print "Choose an option: "
  end

  def save_text
    text = ReaderTextWordCollectionFile.get_string('./input.txt')
    collection = TextWordCollection.get_collection_words_from_string(text)
    WriterTextWordCollectionInFile.save_file_use_marshal(collection, @collection_dir + '/')

    puts "Text (#{collection.get_info[:name]}) saved successfully from input.txt!"
  end

  def compare_collections_with_dictionary
    known_words = load_known_words

    words_to_exclude = load_exceptions
    existing_collections = ReaderTextWordCollectionFile.load_array_objects_from_folder(@collection_dir, '.marshal')
    
    filtered_collections = []
    existing_collections.each do |text|
      filtered_collections << DictionaryOperations.exclude_words(text.get_collection_words, words_to_exclude)
    end
    
    filtered_collections.each_with_index do |collection, index|
      comparison = TextComparison.compare_word_lists(collection, known_words)
      puts "\nComparison with collection '#{existing_collections[index].get_info[:name]}':"
      puts "Known words: #{comparison[:known_word_count]}"
      puts "Total words: #{comparison[:total_word_count]}"
      puts "Percentage known: #{comparison[:percentage_known]}%"
    end
  end

  def load_known_words
    dictionary_path = File.join(@dictionary_dir, 'dictionary.marshal')
    if File.exist?(dictionary_path)
      dictionary = Dictionary.get_dictionary_from_file(@dictionary_dir, 'dictionary')
      dictionary.dictionary
    else
      puts "No dictionary found. Make sure to create and save a dictionary first."
      []
    end
  end

  def load_exceptions
    if File.exist?(@exceptions_file)
      File.read(@exceptions_file).split("\n").map(&:strip)
    else
      puts "No exceptions file found."
      []
    end
  end

  def exclude_words_from_collections(collections, words_to_exclude)
    collections.map do |collection|
      filtered_words = collection.get_collection_words.reject { |word, _| words_to_exclude.include?(word) }
      TextWordCollection.new(filtered_words.merge(info: collection.get_info))
    end
  end

  def load_existing_collections
    collections = ReaderTextWordCollectionFile.load_array_objects_from_folder(@collection_dir, '.marshal', '.json')

    if collections.empty?
      puts "No collections found."
    else
      puts "Loaded collections:"
      collections.each_with_index do |collection, index|
        puts "#{index + 1}. #{collection.get_info[:name]} (Created: #{collection.get_info[:data_create]})"
      end
    end
  end

  def exit_program
    puts "Exiting the program. Goodbye!"
    exit
  end
end
