task default: "test"

desc "Run all tests except `kitchen`"
task test: [:rubocop, :foodcritic, :chefspec]

desc "Run all tests"
task all_tests: [:rubocop, :foodcritic, :chefspec, "kitchen:all"]

require "rubocop/rake_task"
RuboCop::RakeTask.new

require "foodcritic"
FoodCritic::Rake::LintTask.new do |t|
  t.options = { fail_tags: ["any"] }
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:chefspec) do |t|
  t.rspec_opts = "--color --format progress"
end

require "kitchen/rake_tasks"
Kitchen::RakeTasks.new
