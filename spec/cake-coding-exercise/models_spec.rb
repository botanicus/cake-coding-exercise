require 'spec_helper'

describe CakeCodingExercise::Venue do
  subject { described_class.new(name: 'Brewdog Shoreditch') }

  it { has_many(:tabs) }
end

describe CakeCodingExercise::Tab do
  it { belongs_to(:venue, CakeCodingExercise::Venue.new) }
  it { has_many(:user_tabs) }
end

describe CakeCodingExercise::Tab do
end

describe CakeCodingExercise::UserTab do
  it { belongs_to(:tab, CakeCodingExercise::Tab.new) }
  it { belongs_to(:user, CakeCodingExercise::User.new) }
  it { has_many(:payments) }
end

describe CakeCodingExercise::User do
  it { has_many(:user_tabs) }
  it { has_many(:tabs) }
end

describe CakeCodingExercise::Payment do
  it { belongs_to(:user_tab, CakeCodingExercise::UserTab.new) }
  it { belongs_to(:venue, CakeCodingExercise::Venue.new) }

  context 'before save hooks' do
    subject do
      described_class.new(user_tab: user_tab)
    end

    let(:venue) do
      CakeCodingExercise::Venue.new(name: 'Brewdog Clapham')
    end

    let(:tab) do
      CakeCodingExercise::Tab.new(venue: venue)
    end

    let(:user_tab) do
      CakeCodingExercise::UserTab.new(tab: tab)
    end

    it 'sets the venue' do
      expect { subject.save }.to change { subject.venue }.from(nil).to(venue)
    end
  end
end
