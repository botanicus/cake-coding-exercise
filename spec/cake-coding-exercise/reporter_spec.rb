require 'spec_helper'

describe CakeCodingExercise::VenueRow do
  subject { described_class.new('Brewdog Shoreditch', payments) }

  let(:payments) do
    3.times.map do |i|
      CakeCodingExercise::Payment.new(amount: '10.50')
    end
  end

  it "has venue_name attribute" do
    expect(subject.venue_name).to eq('Brewdog Shoreditch')
  end

  it "has trans_count attribute" do
    expect(subject.trans_count).to eq(3)
  end

  it "has pound_value attribute" do
    expect(subject.pound_value).to eq(10.50 * 3)
  end
end

describe CakeCodingExercise::Reporter do
  describe '.results' do
    before do
      john_doe = CakeCodingExercise::User.create
      ella = CakeCodingExercise::User.create
      brewdog_shoreditch = CakeCodingExercise::Venue.create(name: 'Brewdog Shoreditch')
      brewdog_clapham = CakeCodingExercise::Venue.create(name: 'Brewdog Clapham')
      translate_bar = CakeCodingExercise::Venue.create(name: 'Translate Bar')

      # Off the date range visit.
      johns_brewdog_tab_tuesday = CakeCodingExercise::Tab.create(venue: brewdog_shoreditch)
      johns_brewdog_tab_tuesday = CakeCodingExercise::UserTab.create(user: john_doe, tab: johns_brewdog_tab_tuesday)
      CakeCodingExercise::Payment.create(created_at: 6.days.ago, user_tab: johns_brewdog_tab_tuesday, amount: BigDecimal.new('9.50'), status: true)

      # John on his own.
      johns_brewdog_tab_saturday = CakeCodingExercise::Tab.create(venue: brewdog_shoreditch)
      johns_brewdog_tab_saturday = CakeCodingExercise::UserTab.create(user: john_doe, tab: johns_brewdog_tab_saturday)
      CakeCodingExercise::Payment.create(created_at: 3.days.ago, user_tab: johns_brewdog_tab_saturday, amount: BigDecimal.new('10.50'), status: true)

      # John and Ella.
      john_and_ellas_brewdog_tab_sunday = CakeCodingExercise::Tab.create(venue: brewdog_clapham)

      johns_brewdog_tab_sunday = CakeCodingExercise::UserTab.create(user: john_doe, tab: john_and_ellas_brewdog_tab_sunday)
      CakeCodingExercise::Payment.create(created_at: 2.days.ago, user_tab: johns_brewdog_tab_sunday, amount: BigDecimal.new('11.50'), status: true)

      ellas_brewdog_tab_sunday = CakeCodingExercise::UserTab.create(user: ella, tab: john_and_ellas_brewdog_tab_sunday)
      CakeCodingExercise::Payment.create(created_at: 2.days.ago, user_tab: ellas_brewdog_tab_sunday, amount: BigDecimal.new('12.50'), status: true)

      # John and Ella, John is broke.
      john_and_ellas_brewdog_tab_monday = CakeCodingExercise::Tab.create(venue: brewdog_shoreditch)

      johns_brewdog_tab_monday = CakeCodingExercise::UserTab.create(user: john_doe, tab: john_and_ellas_brewdog_tab_monday)
      CakeCodingExercise::Payment.create(created_at: 1.days.ago, user_tab: johns_brewdog_tab_monday, amount: BigDecimal.new('13.50'), status: false)

      ellas_brewdog_tab_monday = CakeCodingExercise::UserTab.create(user: ella, tab: john_and_ellas_brewdog_tab_monday)
      CakeCodingExercise::Payment.create(created_at: 1.days.ago, user_tab: johns_brewdog_tab_monday, amount: BigDecimal.new('14.50'), status: true)
    end

    # Manually counted and ugly, I know. Out of time.
    it "works" do
      results = CakeCodingExercise::Reporter.results(5.days.ago, Date.today)
      actual_results = results.map { |r| [r.venue_name, r.trans_count, r.pound_value.to_f] }
      expected_results = [['Brewdog Clapham', 2, 24.0], ['Brewdog Shoreditch', 2, 25.0]]
      expect(actual_results).to eq(expected_results)
    end
  end
end




