require 'simplecov'
require 'simplecov/parallel'

SimpleCov::Parallel.activate

SimpleCov.merge_timeout 3600

SimpleCov.minimum_coverage 85

SimpleCov.formatters =
  SimpleCov::Formatter::MultiFormatter.new([
                                             SimpleCov::Formatter::HTMLFormatter
                                           ])

SimpleCov.start 'rails' do
  coverage_dir 'tmp/coverage'

  add_filter '/bin/'
  add_filter '/config/'
  add_filter '/coverage/'
  add_filter '/db/'
  add_filter '/log/'
  add_filter '/public/'
  add_filter '/spec/'
  add_filter '/storage/'
  add_filter '/tmp/'
  add_filter '/vendor/'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Auth', 'app/auth'
end
