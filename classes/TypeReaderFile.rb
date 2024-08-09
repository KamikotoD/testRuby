class TypeReaderFile
  def self.marshal_read(file_path)
    File.open("#{file_path}.marshal", 'rb') { |file| Marshal.load(file) }
  end
  def self.marshal_write(file_path, data)
    File.open("#{file_path}.marshal", 'wb') do |file|
      Marshal.dump(data, file)
    end
  end
end