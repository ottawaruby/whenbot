# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trigger do    
    task_id { |t| t.association(:task) }
    channel "Developer"
    trigger "SampleSearch"
    polling_trigger false
    parameters({ search_term: 'MyText' })
    match_data nil
    extra_data nil
    last_matched "2012-04-19 19:41:22"
    webhook_uid "MyString"    
    active true
    
    factory :matching_trigger do
      parameters({ search_term: 'banana' })
      extra_data({ some_value: 'saved result' })
    end
    
    factory :non_matching_trigger do
      parameters({ search_term: "a string that shouldn't be matched" })
    end
    
    factory :twitter_new_tweet_from_trigger do
      channel "Twitter"
      trigger "NewTweetFrom"
      parameters({ username: 'rails' })
      task_id { |task| task.association(:developer_task) }
    end
    
    factory :single_trigger_under_new_task do
      task
    end
  end
end
