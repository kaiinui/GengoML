require 'pp'
require_relative 'gengoml'

parser = GengoML::Parser.new

pp parser.parse_file("sample.txt")