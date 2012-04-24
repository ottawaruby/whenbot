require 'test_helper'

class TaskFlowsTest < ActionDispatch::IntegrationTest

  test "New Task page should show installed Trigger Channels" do
    visit tasks_new_path
    assert page.has_text?('Trigger Channels'), "Trigger Channels list was not found"
    assert page.has_text?('Developer'), "Developer Channel was not detected"
  end
  
  test "New Task page should show Triggers when a Channel is clicked" do
    visit tasks_new_path
    assert page.has_no_text?('Sample Search'), "Sample Search trigger is shown before User clicked on the \"Developer\" Channel link"
    click_on 'Developer'
    assert page.has_text?('Sample Search'), "Developer's Sample Search Trigger wasn't displayed"
  end
  
end
