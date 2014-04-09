require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs= FileList['lib/**/*'].select{ |d| File.directory?(d) }
  t.test_files = FileList['test/**/*'].select{ |d| !File.directory?(d) }
  t.verbose = true
end
