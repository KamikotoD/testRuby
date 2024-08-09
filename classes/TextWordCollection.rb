require 'digest'
class TextWordCollection
  attr_reader :collection_words
  def initialize(collection_words)
    @collection_words = collection_words
  end

  def self.get_collection_words_from_string(string_text)
    
    collection_string, hash_name = get_collection_string_and_hash(string_text)
    collection_words = { 
      info: {
        name: string_text.strip.split("\n").shift,
        data_create: Time.now,
        hash: hash_name
      } 
    }
    collection_string.each do |word|
      collection_words[word] = 0
    end

    collection_string.each do |word|
      collection_words[word] += 1
    end
    
    
    return TextWordCollection.new(collection_words)
  end

  def get_info
    @collection_words[:info]
  end

  def get_collection_words
    @collection_words.reject { |key, _| key == :info }
  end

  private

  def self.get_collection_string_and_hash(string_text)
    collection_string = string_text.downcase()
    .gsub(/[^a-z\s`'’-]/, '')
    .gsub(/\b'\b|(\s)'|'(\s)/, '\1\2')
    .gsub(/\b`\b|(\s)`|`(\s)/, '\1\2')
    .gsub(/\b’\b|(\s)’|’(\s)/, '\1\2')
    .split()
    hash_name = Digest::SHA256.hexdigest(collection_string.join(' '))

    return collection_string, hash_name
  end
end