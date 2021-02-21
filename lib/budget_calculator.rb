# frozen_string_literal: true

require 'date'
require 'period'
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
    period = Period.new(start_at, end_at)

    until current_date > end_at
      budget = budgets.find do |budget|
        budget.year_month == current_date.strftime('%Y%m')
      end

      unless budget.nil?
        amount += budget.daily_amount * period.overlaping_days(budget.period)
      end

      current_date = current_date.next_month
    end

    amount
  end
end
