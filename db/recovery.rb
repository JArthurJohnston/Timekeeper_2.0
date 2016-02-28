class Recovery

  def recover
    tuesday = 23
    wednesday = 24
    w4089 = 1
    wstu = 3
    wmcr = 9
    itWin10 = 64
    sh8956 = 60
    sh8935 = 62

    act_on(time_on(tuesday, 8, 45), time_on(tuesday, 10, 0), w4089)
    act_on(time_on(tuesday, 10, 0), time_on(tuesday, 10, 15), wstu)
    act_on(time_on(tuesday, 10, 15), time_on(tuesday, 12, 0), w4089)
    act_on(time_on(tuesday, 13, 0), time_on(tuesday, 13, 45), wmcr)
    act_on(time_on(tuesday, 13, 45), time_on(tuesday, 17, 30), w4089)

    act_on(time_on(wednesday, 8, 45), time_on(wednesday, 9, 00), w4089)
    act_on(time_on(wednesday, 9, 0), time_on(wednesday, 9, 45), itWin10)
    act_on(time_on(wednesday, 9, 45), time_on(wednesday, 10, 0), w4089)
    act_on(time_on(wednesday, 10, 0), time_on(wednesday, 10, 15), wstu)
    act_on(time_on(wednesday, 10, 15), time_on(wednesday, 10, 30), w4089)
    act_on(time_on(wednesday, 10, 30), time_on(wednesday, 10, 45), wmcr)
    act_on(time_on(wednesday, 10, 45), time_on(wednesday, 12, 0), sh8956)
    act_on(time_on(wednesday, 13, 15), time_on(wednesday, 13, 30), sh8935)
    act_on(time_on(wednesday, 13, 30), time_on(wednesday, 17, 30), w4089)

  end

  def act_on(s, e, c)
    Activity.create(start_time: s,end_time: e,timesheet_id: 1,story_card_id: c)
  end

  def time_on(day, hours, minutes)
    year = 2016
    month = 2
    offset = "-5"
    DateTime.new(year, month, day, hours, minutes, 0, offset)
  end

end