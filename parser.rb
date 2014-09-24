class GengoML::Parser

  # @return Hash
  def parse_file(filename)
    body = File.open(filename).read
    parse(body)
  end

  # @return Hash
  def parse(text)
    to_hash(text)
  end

  private

  # @return Hash
  def to_hash(body)
    hash = {}
    to_key_value_hash(body).each do |h|
      next unless h
      key = h[:key]
      hash[key] = h[:value]
    end
    hash
  end

  # @return Array<Hash>
  def to_key_value_hash(body)
    key_values = body.split("[[[@")
    key_values.map do |key_value|
      next if key_value == ""
      parse_key_value(key_value)
    end
  end

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
    key = key_value.split("]]]")[0]
    unclean_value = key_value.split("]]]")[1]
    value = clean_value(unclean_value)

    {
        key: key,
        value: value
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