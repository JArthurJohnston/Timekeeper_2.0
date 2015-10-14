module StatementOfWorkDisplay

  def display_string
    "SOW: %{number} : %{client}" % {number: number, client: client}
  end
end