# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
  setup do
    @title = Faker::Lorem.sentence
    @body = Faker::Lorem.paragraph_by_chars(number: 51, supplemental: false)
  end

  test 'visiting the index' do
    visit posts_path

    page.assert_selector('h1', text: 'Posts')
    page.assert_selector('a',  text: 'New Post')
    page.assert_selector('a',  text: 'Home')
    page.assert_selector('a',  text: 'Posts')
  end

  test 'visit post page' do
    visit posts_path

    click_on 'Show', match: :first

    page.assert_selector('h3', text: 'Comments')
    page.assert_selector('form')
    page.assert_selector('a', text: 'Edit')
    page.assert_selector('a', text: 'Back')

    click_on 'Back'

    page.assert_selector('h1', text: 'Posts')
  end

  test 'create new post' do
    visit posts_path

    click_on 'New Post'

    fill_in('Title', with: @title)
    fill_in('Body', with: @body)

    click_on 'Create Post'

    page.assert_text('Post was successfully created.')
    page.assert_selector('h1', text: @title)
    page.assert_selector('p', text: @body)
  end

  test 'update post from posts list page' do
    visit posts_path

    click_on 'Edit', match: :first
    page.assert_selector('h1', text: 'Editing post')
    fill_in('Title', with: @title)
    fill_in('Body', with: @body)

    click_on 'Update Post'

    page.assert_text('Post was successfully updated.')
    page.assert_selector('h1', text: @title)
    page.assert_selector('p', text: @body)
  end

  test 'update post from post page' do
    post = posts(:one)
    visit post_path(post)

    page.all('a', text: 'Edit')[1].click

    page.assert_selector('h1', text: 'Editing post')
    fill_in('Title', with: @title)
    fill_in('Body', with: @body)

    click_on 'Update Post'

    page.assert_text('Post was successfully updated.')
    page.assert_selector('h1', text: @title)
    page.assert_selector('p', text: @body)
  end

  test 'destroy post' do
    visit posts_path

    text = page.all('tr')[1].text
    page.assert_selector('tr', text: text)

    page.accept_alert 'Are you sure?' do
      click_on 'Destroy', match: :first
    end

    page.assert_no_selector('tr', text: text)
    page.assert_text('Post was successfully destroyed.')
  end

  test 'create comment' do
    post = posts(:without_comments)

    visit post_path(post)

    fill_in(with: @body, name: 'post_comment[body]')
    click_on 'Create Comment'

    page.assert_text('Comment was successfully created.')
    page.assert_text(@body)
  end
end
# END
