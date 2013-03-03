FactoryGirl.define do
  factory :item do
  	name "foo bar item"
  	description "some description"
  	association :list
  end
end
