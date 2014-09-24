class GengoML::DotStringsBuilder
  def build_from_hash(hash)
    body = ""
    hash.each do |key, value|
      body += row(key, value)
    end
    body
  end

  def row(key, value)
    "\"#{key}\" = \"#{escape(value)}\";\n"
  end

  def escape(text)
    double_quote_escaped = escape_double_quotes(text)
    escape_line_break(double_quote_escaped)
  end

  def escape_double_quotes(text)
    text.gsub("\"", "")
  end

  def escape_line_break(text)
    text.gsub("\n", "")
  end
end