FactoryGirl.define do
  factory :user do
    name "Michael"
    email "michael@example.org"
    password "foobar"
    password_confirmation "foobar"
  end
end
