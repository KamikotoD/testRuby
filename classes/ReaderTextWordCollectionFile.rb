class ReaderTextWordCollectionFile
  def self.get_string(file_path)
    begin
      content = File.read(file_path)
    rescue Errno::ENOENT
      puts "Error: File not found at path '#{file_path}'"
      content = nil
    rescue Errno::EACCES
      puts "Error: Insufficient permissions to read the file at path '#{file_path}'"
      content = nil
    rescue => e
      puts "An error occurred: #{e.message}"
      content = nil
    end
    content
  end
  def self.load_object_from_file(file_path, name)
    begin
      content = case File.extname(file_path)
                when '.marshal'
                  File.open(file_path, 'rb') { |file| Marshal.load(file) }
                when '.json'
                  JSON.parse(File.read(file_path))
                else
                  raise "Unsupported file format"
                end
      return TextWordCollection.new(content) 
    rescue Errno::ENOENT
      puts "Error: File not found at path '#{file_path}'"
      content = nil
    rescue Errno::EACCES
      puts "Error: Insufficient permissions to read the file at path '#{file_path}'"
      content = nil
    rescue => e
      puts "An error occurred: #{e.message}"
      content = nil
    end
  end

  def self.load_array_objects_from_folder(folder_path, *file_types)
    raise ArgumentError, "At least one file type must be provided" if file_types.empty?
    pattern = File.join(folder_path, "*{#{file_types.join(',')}}")
    files = Dir.glob(pattern)
    objects = files.map do |file|
      name = File.basename(file, File.extname(file))
      load_object_from_file(file, name)
    end
    objects.compact
  end
  
end