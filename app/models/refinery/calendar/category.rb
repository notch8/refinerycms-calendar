module Refinery
  module Calendar
    class Category < Refinery::Core::BaseModel
      has_and_belongs_to_many :events
      validates :name, presence: true, uniqueness: true

      translates :name
      class Translation
      end
      acts_as_indexed :fields => [:name]


    end
  end
end
