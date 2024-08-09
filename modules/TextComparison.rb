
module TextComparison

  def self.calculate_known_words(text_collections, word_list)
    known_words = 0
    word_list.each do |word|
      known_words += text_collections[word].to_i
    end
    known_words
  end

  def self.calculate_total_words(text_collections)
    total_words = 0
    text_collections.each_value do |count|
      total_words += count
    end
    total_words
  end

  def self.compare_word_lists(text_collections, word_list)
    known_words = calculate_known_words(text_collections, word_list)
    total_words = calculate_total_words(text_collections)
    percentage_known = calculate_percentage(known_words, total_words)
    
    {
      known_word_count: known_words,
      total_word_count: total_words,
      percentage_known: percentage_known
    }
  end
  private
  def self.calculate_percentage(known_words, total_words)
    (100.0 * known_words / total_words).round(2)
  end
end