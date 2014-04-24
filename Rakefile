require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs= FileList['lib/**/*'].select{ |d| File.directory?(d) }
  t.test_files = FileList['test/**/*'].reject{ |d| File.directory?(d) }
end

