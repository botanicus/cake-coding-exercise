require 'date'

module CakeCodingExercise
  class VenueRow
    attr_reader :venue_name

    def initialize(venue_name, payments)
      @venue_name = venue_name
      @payments = payments
    end

    def trans_count
      @payments.length
    end

    def pound_value
      @payments.reduce(0) do |sum, payment|
        sum + payment.amount
      end
    end
  end

  class Reporter
    def self.results(from_date, till_date)
      from_date = self.ensure_date(from_date)
      till_date = self.ensure_date(till_date)

      self.new(from_date, till_date).results
    end

    # @api private
    def self.ensure_date(date)
      date.respond_to?(:iso8601) ? date : Date.parse(date)
    end

    def initialize(from_date, till_date)
      @from_date, @till_date = from_date, till_date
    end

    # This could be optimised with joins to retrieve venue
    # name as part of the data set if necessary, but it doesn't
    # seem important for now.
    def results
      successful_payments_in_date_range
        .group_by(&:venue_id)
        .reduce(Array.new) do |list, (venue_id, payments)|
          list << VenueRow.new(Venue.find(venue_id).name, payments)
        end
        .sort_by { |row| row.pound_value }
    end

    private
    def successful_payments_in_date_range
      Payment
        .where(created_at: @from_date..@till_date, status: true)
    end
  end
end
