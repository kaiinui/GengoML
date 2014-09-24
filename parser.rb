class GengoML::Parser
  def parse_file(filename)
    body = File.open(filename).read
    parse(body)
  end

  def parse(body)
    key_values = body.split("[[[@")
    key_values.map do |key_value|
      next if key_value == ""
      parse_key_value(key_value)
    end
  end

  private

  # Typically follows are given as `key_value`
  #
  # ```
  # HELLO_WORLD]]]
  #
  # Hello!
  #
  #
  # ```
  def parse_key_value(key_value)
    pp key_value.split("]]]")
    key = key_value.split("]]]")[0]
    unclean_value = key_value.split("]]]")[1]
    value = clean_value(unclean_value)

    {
        key: key,
        text: value
    }
  end

  def clean_value(unclean_value)
    line_breaks = unclean_value.slice!(0, 2) # Assume it contains two ¥n at first.
    line_breaks.gsub!("\n", "")
    unclean_value.prepend(line_breaks)

    line_breaks = unclean_value.slice!(unclean_value.size-2 , 2) # Assume it contains two ¥n at last.
    line_breaks.gsub!("\n", "")
    unclean_value += line_breaks

    unclean_value
  end
end