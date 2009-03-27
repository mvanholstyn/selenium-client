require File.join(File.dirname(__FILE__), *%W[.. lib selenium rake tasks])
Selenium::Rake::RemoteControlStartTask.new do |rc|
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = File.join(File.dirname(__FILE__), *%W[.. selenium-server.jar])
  rc.additional_args << "-singleWindow"
  rc.additional_args << "> /dev/null"
end

Selenium::Rake::RemoteControlStopTask.new do |rc|
end

# TODO: How can I get around this?
require File.join(Rails.root, *%W[vendor gems rspec-1.1.11 lib spec rake spectask])

desc 'Run acceptance tests for web application on default browser defined in config/selenium.yml'
Spec::Rake::SpecTask.new('selenium') do |t|
  t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/selenium_spec.opts\""]
  path = ENV['CC_BUILD_ARTIFACTS'] || "./tmp"
  file = ENV['SELENIUM_CONFIGURATION'] || "acceptance_tests_report"
  t.spec_opts << "--format='Selenium::RSpec::SeleniumTestReportFormatter:#{path}/#{file}.html'"
  t.spec_files = FileList['spec/selenium/*_spec.rb']
end

desc 'Run acceptance tests for web application on all browsers defined in config/selenium.yml'
task 'selenium:all' do
  Selenium::Configuration.each do |configuration|
    ENV['SELENIUM_CONFIGURATION'] = configuration
    Rake::Task["selenium"].invoke
  end
end
