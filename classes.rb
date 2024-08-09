
















=begin
  class DictionaryWords
  attr_reader :hash_name, :dictionary_words
  def self.get_dictionary_words_from_string(string_text)
    first_line = string_text.split("\n").first
    string_text = string_text.downcase()
    .gsub(/[^a-z\s`'’-]/, '')
    .gsub(/\b'\b|(\s)'|'(\s)/, '\1\2')
    .gsub(/\b`\b|(\s)`|`(\s)/, '\1\2')
    .gsub(/\b’\b|(\s)’|’(\s)/, '\1\2')
    hash_name = Digest::SHA256.hexdigest(string_text)
    string_text = string_text.split
    dictionary_words = {}
    string_text.each do |word|
      dictionary_words[word] = 0
    end
    string_text.each do |word|
      dictionary_words[word] +=1 
    end
    return DictionaryWords.new(dictionary_words, hash_name)
  end 
  def initialize(dictionary_words,hash_name)
    @dictionary_words = dictionary_words
    @hash_name = hash_name
  end
end
=end






