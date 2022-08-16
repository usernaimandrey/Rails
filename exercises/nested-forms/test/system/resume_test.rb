# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'presence fields for work' do
    visit new_resume_url

    fill_in 'resume_name', with: 'Resume Name'
    fill_in 'resume_contact', with: 'Contact'

    find('#education .add_fields').click
    find('#work .add_fields').click

    assert_selector '#education input', count: 2
    assert_selector '#education select', count: 6
    assert_selector '#work input', count: 1
    assert_selector '#work select', count: 6
  end

  test 'create resume' do
    visit new_resume_url

    fill_in 'resume_name', with: 'Resume Name'
    fill_in 'resume_contact', with: 'Contact'

    find('#education .add_fields').click
    fill_in 'Institution', with: 'MTUSI'
    fill_in 'Faculty', with: 'infocommunications'
    within(:xpath, './/div[@class="form-group date required resume_educations_begin_date"]') do
      find("option[value='2022']").click
      find('option', text: 'December').click
      find("option[value='4']", text: '4').click
    end

    find('#work .add_fields').click
    fill_in 'Company', with: 'Hexlet'
    within(:xpath, './/div[@class="form-group date required resume_works_begin_date"]') do
      find("option[value='2021']").click
      find('option', text: 'November').click
      find("option[value='1']", text: '1').click
    end
    click_on 'Create Resume'

    page.assert_text 'Resume was successfully created.'
    page.assert_selector('h2', text: 'Resume Name')
    page.assert_selector('div', text: 'Contact')
    page.assert_selector('div', text: 'MTUSI')
    page.assert_selector('div', text: 'Dec 2022')
    page.assert_selector('div', text: 'Hexlet')
    page.assert_selector('div', text: 'Nov 2021')
  end
end
