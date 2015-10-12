module ActivityValidator

  def start_comes_before_end
    unless end_time.nil?
      if end_time < start_time
        errors.add(:end_time, 'Cant be before the start time')
      end
    end
  end
end