class NullProject < Project
  include NullModel

  def user
    User::NULL
  end

  def name
    'N/A'
  end

  def job_id
    ''
  end

  def story_cards
    []
  end

end