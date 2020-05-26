FactoryBot.define do
  factory :event do
    name {'event1'}
    description {'desc1'}
    date {Date.new(2001, 2, 3)}
    creator {User.first}
  end
end
