# frozen_string_literal: true

class Period
  attr_reader :start_at, :end_at

  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
  end

  def days
    end_at.mjd - start_at.mjd + 1
  end

  def overlaping_days(period)
    start_day = [period.start_at, start_at].max
    end_day = [period.end_at, end_at].min

    end_day.mjd - start_day.mjd + 1
  end
end
