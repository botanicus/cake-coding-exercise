module CakeCodingExercise
  class Venue < ActiveRecord::Base
    has_many :tabs
  end

  class Tab < ActiveRecord::Base
    belongs_to :venue
    has_many :user_tabs
  end

  class UserTab < ActiveRecord::Base
    belongs_to :tab
    belongs_to :user
    has_many :payments
  end

  class User < ActiveRecord::Base
    has_many :user_tabs
    has_many :tabs, through: :user_tabs
  end

  class Payment < ActiveRecord::Base
    belongs_to :user_tab

    # Added for caching purposes.
    #
    # Once the payment is created, it won't ever
    # be moved to another venue, so we don't have
    # to worry about consistency issues.
    #
    # Better than doing joins through all the tables.
    belongs_to :venue

    before_save :set_venue

    private
    def set_venue
      self.venue ||= self.user_tab.try(:tab).try(:venue)
    end
  end
end
