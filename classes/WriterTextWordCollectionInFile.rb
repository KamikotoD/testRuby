class WriterTextWordCollectionInFile
  def self.save_file_use_marshal(dictionary_object, path = "")
    File.open("#{path}#{dictionary_object.collection_words[:info][:hash]}.marshal", "wb") do |to_file|
      Marshal.dump(dictionary_object.collection_words, to_file)
    end
  end
  def self.save_file_use_json(dictionary_object, path = "")
    json_content = dictionary_object.collection_words.to_json
    File.open("#{path}#{dictionary_object.collection_words[:info][:hash]}.json", "w") do |to_file|
      to_file.write(json_content)
    end
  end
end
