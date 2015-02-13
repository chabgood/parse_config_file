class Parser
  attr_accessor :results, :errors, :file

  def initialize(args={})
    raise 'A file must be supplied' if args[:file].nil?
    @file = File.open(args[:file])
    @results = []
    @errors = []
  end

  def parse
    file.each do |line|
      line = line.strip  # removes newline
      next if a_comment?(line) || error_if_invalid_line(line)
      results << get_line_result(line)
    end
    self
  end

  private

  def get_line_result(line)
    stripped_line = line.split('=').last.strip
    return true if stripped_line =~ /(yes|true|on)/
    return false if stripped_line =~ /(no|false|off)/
    stripped_line
  end

  def a_comment?(line)
    line.start_with?('#')
  end

  def error_if_invalid_line(line)
    if invalid_line?(line)
      errors << line
      return true
    end
  end

  def invalid_line?(line)
    stripped_line = line.split('=').each(&:strip)
    stripped_line.length < 2 || line !~ /=/
  end 

end

parser = Parser.new(:file => '/home/chabgood/projects/parse_config_file/spec/invalid_file.txt')
parser.parse
p parser.inspect
