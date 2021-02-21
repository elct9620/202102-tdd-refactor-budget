# frozen_string_literal: true

require 'period'

class Budget
  attr_reader :year_month, :amount

  def initialize(year_month, amount)
    @year_month = year_month
    @amount = amount
  end

  def first_day
    @first_day ||= Date.parse("#{year_month}01")
  end

  def last_day
    @last_day ||= first_day.next_month.prev_day
  end

  def period
    Period.new(first_day, last_day)
  end

  def daily_amount
    @daily_amount = amount.to_f / period.days
  end
end
