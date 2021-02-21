# frozen_string_literal: true

class Period
  attr_reader :start_at, :end_at

  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
  end

  def overlaping_days(budget)
    start_day = [budget.first_day, start_at].max
    end_day = [budget.last_day, end_at].min

    end_day.mjd - start_day.mjd + 1
  end
end
