FactoryGirl.define do
	sequence :email do |n|
	  "example#{n}@foo.bar"
	end

  factory :user do
    name 'Test User'
    email { generate(:email) }
    password '123456'
    password_confirmation '123456'
  end
end