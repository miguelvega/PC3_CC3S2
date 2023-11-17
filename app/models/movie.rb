class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings)
    where('UPPER(rating) IN (?)',ratings.map(&:upcase))
  end
end
