# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "My Task"
    active true
    last_executed "2012-04-19 19:41:22"
    
    factory :developer_task do
      name "Developer Task"
    end
  end
end
