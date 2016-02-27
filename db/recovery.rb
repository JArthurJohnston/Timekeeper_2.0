class Recovery

  def recover
    year = 2016
    month = 2
    tuesday = 23
    wednesday = 24
    offset = "-5"

    timeOn = lambda {|day, hours, minutes| DateTime.new(year, month, day, hours, minutes, 0, offset)}

    [
        [Activity.create(start_time: timeOn.call(), end_time: timeOn.call())]
    ]
  end
end