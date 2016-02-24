module ProjectDisplay

  def display_string
    "%{name} : %{sow}" % {name: name, sow: code}
  end
end