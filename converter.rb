class GengoML::Converter
  def convert(filename)
    parser = GengoML::Parser.new
    hash = parser.parse_file("sample.txt")
    name = filename.split(".")[0]
    builder = GengoML::DotStringsBuilder.new
    strings = builder.build_from_hash hash

    File.open("#{name}.strings", "w") do |f|
      f.write(strings)
    end
  end
end