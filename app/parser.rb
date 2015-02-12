class Parser

  def initialize(args={})
    raise 'A file must be supplied' if args[:file].nil?
    @file = args[:file]
  end

  def parse
    @file.each do |line|
      p line
    end
  end

end
