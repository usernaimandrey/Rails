# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'filter is working' do
    visit posts_url

    fill_in 'q_title_cont', with: 'Find It'

    click_on 'Search'

    found_posts = all('tbody tr')

    assert(found_posts.count == 1)
  end

  test 'filtered on ststus field' do
    visit posts_url
    find("option[value='published']").click

    click_on 'Search'

    found_posts = all('tbody tr')

    assert(found_posts.count == 2)
  end

  test 'filtered on status and name' do
    visit posts_url

    fill_in 'q_title_cont', with: 'One'
    page.find("option[value='published']").click

    click_on 'Search'

    found_posts = all('tbody tr')

    assert(found_posts.count == 1)
  end

  test 'sorted on title' do
    visit posts_url

    click_link('Title')

    found_posts = all('tbody td')

    assert(found_posts[0].text == 'Find It!')

    click_link('Title')

    assert(all('tbody td')[0].text == 'Two')
  end
end
