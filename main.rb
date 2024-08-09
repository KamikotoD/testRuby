require_relative 'classes'
require 'json'
# main.rb
classes_directory = File.join(__dir__, 'classes')
Dir.glob(File.join(classes_directory, '*.rb')).each do |file|
  require_relative file
end

def main
  if __FILE__ == $0
    cli = TextAnalyzerCLI.new
    cli.start
  end
end

main





=begin


=end
