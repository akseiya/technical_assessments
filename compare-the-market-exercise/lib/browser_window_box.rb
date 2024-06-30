# A singleton class for storing and reporting
# a set of browser window size presets (intended
# to match indentified responsive page design
# breakpoints)

class BrowserWindowBox
  AvailablePresets = YAML.load <<-EOF
    :large: [1600,900]
    :thin:  [800,900]
  EOF
  
  @@cv_BrowserWindowBox_current_preset = :large
  
  class << self
    def size
      AvailablePresets[@@cv_BrowserWindowBox_current_preset]
    end
    
    def size=(preset)
      unless AvailablePresets.include? preset
        raise "Unsupported browser window size #{preset}"
      end
      @@cv_BrowserWindowBox_current_preset = preset
    end
    
    def apply_size(browser)
      browser.window.resize_to *self.size
    end
  end
end
