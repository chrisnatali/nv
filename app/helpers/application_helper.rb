# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #format dollar amounts
  def fmt_dollars(amt)
    sprintf("$%0.2f", amt)
  end

  #format event dates
  #Note:  This assumes an event does not last > 1 year
  def fmt_event_dates(start_date, end_date)
    if start_date.yday == end_date.yday
      start_date.strftime("%a, %b %d from %I:%M %p") + end_date.strftime(" to %I:%M %p")
    else
      start_date.strftime("%a, %b %d %I:%M %p") + end_date.strftime(" to %a, %b %d %I:%M %p")
    end
  end
end
