feature 'Cooking cookies' do
  before do
    CookingJob.any_instance.stub(:cook) #simulate the oven device cooking
  end

  scenario 'Cooking a single cookie' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'cookie[how_many]', with: 1
    click_button 'Mix and bake'

    expect(CookingJob.jobs.size).to eq 1
    CookingJob.drain

    visit oven_path(oven)   #new information on oven page after job runs!
    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content 'Chocolate Chip'
    expect(page).to have_content 'Your Cookie is Ready'

    click_button 'Retrieve Cookie'
    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'
    expect(page).to have_content 'Oven emptied!'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '1 Cookie'
    end
  end

  scenario 'Trying to bake a cookie while oven is full' do
    user = create_and_signin
    oven = user.ovens.first

    oven = create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'cookie[how_many]', with: 1
    click_button 'Mix and bake'

    expect(CookingJob.jobs.size).to eq 1
    CookingJob.drain
    visit oven_path(oven)

    click_link_or_button  'Prepare Cookie'
    expect(page).to have_content 'A cookie or more is already in the oven!'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking multiple cookies' do
    user = create_and_signin
    oven = create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'cookie[how_many]', with: 3
    click_button 'Mix and bake'

    expect(CookingJob.jobs.size).to eq 1
    CookingJob.drain
    visit oven_path(oven)

    click_button 'Retrieve Cookie'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '3 Cookies'
    end
  end
end
