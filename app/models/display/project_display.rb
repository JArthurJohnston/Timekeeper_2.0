module ProjectDisplay

  def display_string
    "%{name} SOW: %{number}" % {name: name, number: statement_of_work.number}
  end
end