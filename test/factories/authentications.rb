# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    channel "MyString"
    parameters "MyText"
  end
end
