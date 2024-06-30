module EnergyCompare
  include Capybara::DSL
  
  # References common to all stages of the comparison wizard
  
  TestStart = 'https://energy.comparethemarket.com/energy/v2/?AFFCLIE=TSTT'
  FixedTestPostCode = 'PE2 6YS'
  SectionTicked = '.tick-area'
  
  SectionSelector = ".//div[@class='question-wrapper' and contains(.,'%s')]"
  
  def section_selector(question)
    SectionSelector % question
  end
      
  def main_header
    find('h2.main-heading')
  end
  
  def section(question)
    find_ section_selector(question)
  end

  def be_a_disabled_button
    match_css('.button-disabled')
  end
  
  # Recognize and handle xpaths starting with /, //, ./ or .//
  
  def detect_xpath(selector)
    selector.gsub(/^\./,'')[0] == '/' ? [:xpath, selector] : selector
  end
  
  %w{find have_selector have_no_selector}.each do |auto_dsl_method|
    define_method(:"#{auto_dsl_method}_") do |selector, options = nil|
      if options
        send auto_dsl_method.to_sym, *detect_xpath(selector), options
      else
        send auto_dsl_method.to_sym, *detect_xpath(selector)
      end
    end
  end
  
  class YourSupplier
    class << self
      
      def single_supplier_selection
        section_selector 'Is your gas & electricity from the same supplier?'
      end
      
      def i_have_the_bill
        find '.have-bill-yes'
      end
      
      def find_the_fixed_postcode
        within(section('What is your postcode?')) do
          page.has_field? 'postcode' # added as extra safety measure after stability check surfaced the delayed appearance of Find postcode button
          fill_in 'postcode', with: FixedTestPostCode
          page.has_button? 'Find postcode' # the button apparently tends to become visible with some delay, creating a trap for click_on
          click_on 'Find postcode'
        end
      end
      
      def next_stage_button
        find('#goto-your-supplier-details')
      end
    end
  end
end


