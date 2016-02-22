module ProjectDisplay

  def display_string
    "%{name} : %{sow}" % {name: name, sow: invoice_number}
  end
end