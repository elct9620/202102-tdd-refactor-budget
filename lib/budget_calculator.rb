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
    period = Period.new(start_at, end_at)
    @repo.get_all.reduce(0) do |sum, budget|
      sum + budget.daily_amount * period.overlaping_days(budget.period)
    end
  end
end
