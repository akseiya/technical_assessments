=begin

A user obtains a customized energy quote based on their
current usage and predicted savings estimate based on
their current energy spending.

=end

include EnergyCompare
feature 'Energy comparison for gas and/or electricity' do

  before do
    initialize_browser
    visit TestStart
  end

  it 'starts at Your Supplier stage' do
    expect(main_header).to have_text 'Your Supplier'

    within(section('What is your postcode?')) do
      expect(page).to have_field 'postcode'
      expect(page).to have_button 'Find postcode'
      expect(page).to have_no_selector SectionTicked
    end

    within(section('Do you have your bill handy?')) do
      expect(page).to have_content 'Yes, I have my bill'
      expect(page).to have_content 'No, I don’t have my bill'
    end

    within(section('What do you want to compare?')) do
      expect(page).to have_content 'Gas & Electricity'
      expect(page).to have_content 'Electricity only'
      expect(page).to have_content 'Gas only'
    end

    expect(YourSupplier.next_stage_button).to be_a_disabled_button
    # By default, single supplier option is not visible until
    # a post code is submitted while "I have bill" default option
    # is active. This is a negative check, so it's done last to prevent
    # a false pass by querying too soon. Using a reverse positive check
    # would always wait until built-in timeout.
    expect(page).to have_no_selector_ YourSupplier.single_supplier_selection
  end

  it 'accepts a post code' do
    YourSupplier.find_the_fixed_postcode
    # Accepted answers are marked with tick signs
    expect(section('What is your postcode?')).to have_selector SectionTicked
    # 
  end

  context 'when user has a bill' do
    before :each do
      visit TestStart
      YourSupplier.i_have_the_bill.click
      YourSupplier.find_the_fixed_postcode
    end

    # Actually, why is this only available with bill?
    it 'allows specifying single provider ' do
      expect(page).to have_selector_ YourSupplier.single_supplier_selection
    end
    
  end
end