module Genderable
  extend ActiveSupport::Concern

  included do
    enum writing_gender: {
      fiction: 0, fantasy: 1, non_fiction: 2, poetry: 3, biography: 4, autobiography: 5,
      romance: 6, science_fiction: 7, horror: 8, mystery: 9, thriller: 10, drama: 11
    }, _default: 0
  end
end