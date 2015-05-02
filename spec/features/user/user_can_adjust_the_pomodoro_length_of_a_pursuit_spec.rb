require 'rails_helper'

feature 'User can edit a pursuit' do
  before :each do
    @user = FactoryGirl.create :user
    @pursuit = FactoryGirl.create(:pursuit, { user_id: @user.id })
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User edits default pomodoro length by navigating to edit page' do
    visit edit_user_pursuit_path @pursuit
    select "30", from: "pursuit_pomodoro_length_in_minutes"
    select "00", from: "pursuit_pomodoro_length_in_seconds"
    click_button 'Save'

    expect(page).to have_selector '*[rel="success-flash"]'
    visit user_pursuits_path
    expect(find("tr[data-pursuit-id='#{@pursuit.id}']").find('.default-pomodoro-length').text).to eq('00:30:00')
  end

  scenario 'User can edit a pursuit by clicking edit from show page' do
    visit user_pursuit_path(@pursuit.id)
    click_link 'Edit'

    expect(page).to have_content "Edit: #{@pursuit.name}"
  end

  scenario 'User can edit a pursuit by clicking edit from the PursuitsIndex page' do
    visit user_pursuits_path
    page.find("tr.pursuit[data-pursuit-id=\"#{@pursuit.id}\"]").find('td.actions').click_link('Edit')

    expect(page).to have_content "Edit: #{@pursuit.name}"
  end
end
