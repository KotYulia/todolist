require "rails_helper"

RSpec.feature "Tasks", type: :feature do

  scenario "should open tasks" do
    visit "/"

    expect(page).to have_text("To Do List")
  end
end