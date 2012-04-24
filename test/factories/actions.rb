# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :action do
    task_id 1
    channel "MyString"
    action "MyString"
    parameters "MyText"
    last_executed "2012-04-19 19:09:01"
    extra_data "MyText"
    active true
  end
end
