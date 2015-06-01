# Spec

Write a Ruby class which generates reporting data in a given date range.

The date range is passed in as maybe String format or maybe a Date object.

Here's the data model:

We have the concept of venues (restaurants and bars), tabs (like a "bill" or "check"), and users who open and belong to tabs.

Multiple users can be on the same tab, and a user can be on multiple tabs.
The many-to-many relationship between users and tabs is UserTab
A tab belongs to a venue
A user can make one or more payments on a tab
A payment has a success status (boolean)

The reporting data to generate is a list of venues, the number of transactions at that venue, and the value of the transactions in the given date range.

Each row should be VenueRow class with the 3 methods name, transactions and value (for venue name, number of transactions and £ value).

Assume you're using ActiveRecord in Rails. State any other assumptions or comments to (briefly) explain design decisions.

Here's the existing model classes:

```ruby
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
end
```

The reporting class should have a public method results which returns an ordered array of VenueRows, with highest value first.

Please post your results to your Github/Bitbucket/other public repository.

# Setup

```
cp config/database_sample.yml config/database.yml
bundle install
bundle exec rake migrate
bundle exec rspec -c
```

# My thought process

1. Is there anything useful online? Development is not only about producing good code, but it's a creation process, the point is to produce business value in a reasonable time frame. Often the best code is code you don't have to write. I found https://github.com/8bithero/spleatbot, which in my opinion was doing things it wasn't supposed to (like all the CRUD, validations and the web functionality, the spec says "write a Ruby class"). Also it has no useful specs.

2. Since there was nothing I could start off from, I created a simple project. Although the spec says "assume you're using ActiveRecord in Rails", I went with pure Ruby + ActiveRecord to keep things simple. I value simplicity and clarity, like that you don't have to go over thousand of directories just to see where I put all the stuff. Obviously in a real-world project, I would make a suggestion and I would certainly NOT go with my way because it has more appeal to me, but I take it as the exercise is about showing my thought process rather than anything else.

# Notes

- Providing gemspec enables us to treat this as a gem, so we can do `bundle exec rake migrate` without having to administer `$LOAD_PATH` manually, which is a terrible practice.

- I put instance-specific dependencies into Gemfile and generic dependencies into the gemspec. The app requires the activerecord gem, but it can use any adapter just by providing different adapter in config/database.yml. Hence sqlite3 gem is an instance-specific dependency and should be in Gemfile. Even though it doesn't matter in this case, I like to separate concerns and responsibilities, it always come in handy later on.

- In model specs I'm testing whether a record can be saved and if it has given attributes. Many people argue it's "testing ActiveRecord", but I disagree: firstly, the environment comes to the play and secondly BDD is about specifying the behaviour. So even though I just add a column to a table and Rails will generate the attribute on the fly, by this I'm saying "this object should have this". Besides, maybe I forgot to run the migrations and the attribute is not there, what then? Or what if you switch away from ActiveRecord? Etc.
