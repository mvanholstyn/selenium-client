Dir[File.dirname(__FILE__) + '/../unit/**/*_test.rb'].each do |file|
  require File.dirname(__FILE__) + '/../integration/selenium_mock'
end

if ENV['HEADLESS_TEST_MODE'] == "true"
  puts "Headless test mode detected"
  require File.dirname(__FILE__) + '/../integration/selenium_mock'
else
  require File.dirname(__FILE__) + '/selenium_example'
  require File.dirname(__FILE__) + '/selenium_real_deal'
end
    