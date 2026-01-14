def clean_dir(dir)
  FileUtils.rm_rf(dir)
end

def clean_working_dir
  working_dir = expand_path('.')
  clean_dir(File.join(working_dir, '.git'))
  clean_dir(File.join(working_dir, '.gitted'))
end

def create_fixture_repo(dir, repo_name = 'test_repo')
  fixture_dir = File.expand_path('../../fixtures', __dir__)

  FileUtils.cp_r(File.join(fixture_dir, repo_name, '.'), dir)

  Dir.chdir(dir) do
    File.rename('.gitted', '.git') if File.exist?('.gitted')
  end
end

Given(/^I'm in directory with repo$/) do
  clean_working_dir
  create_fixture_repo(expand_path('.'))
end

Given(/^I'm in directory without repo$/) do
  clean_working_dir
end

Given(/^I'm in directory with repo "(.*?)"$/) do |repo|
  clean_working_dir
  create_fixture_repo(expand_path('.'), repo)
end

Given(/^repo is in "(.*)" subdirectory$/) do |subdir|
  clean_working_dir
  dir = File.join(expand_path('.'), subdir)
  FileUtils.mkdir_p(dir)
  create_fixture_repo(dir)
end
