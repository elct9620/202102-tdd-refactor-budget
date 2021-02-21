# frozen_string_literal: true

require 'date'
require 'budget'
require 'budget_repo'

class BudgetCalculator
  def initialize(repo)
    @repo = repo
  end

  def query(start_at, end_at)
    return 0 if start_at > end_at

    budgets = @repo.get_all
    amount = 0
    current_date = Date.new(start_at.year, start_at.month, 1)

    until current_date > end_at
      budget = budgets.find do |budget|
        budget.year_month == current_date.strftime('%Y%m')
      end

      unless budget.nil?
        current_start_at = current_date.strftime('%Y%m') == start_at.strftime('%Y%m') ? start_at : current_date
        current_end_at = current_date.strftime('%Y%m') == end_at.strftime('%Y%m') ? end_at : current_date.next_month.prev_day
        days_in_query = current_end_at.mjd - current_start_at.mjd + 1

        amount += budget.daily_amount * days_in_query
      end

      current_date = current_date.next_month
    end

    amount
  end
end
