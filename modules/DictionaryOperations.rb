
module DictionaryOperations
  def self.get_words_from_collection(collection)
    dictionary = []
    collection.each do |text_word_collection|
      text_word_collection.get_collection_words.each do |word, _|
        dictionary << word unless dictionary.include?(word)
      end
    end
    dictionary
  end

  def self.exclude_words(dictionary, words_to_exclude)
    dictionary.reject { |word| words_to_exclude.include?(word) }
  end
end


