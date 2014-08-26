def clean_dir(dir)
  FileUtils.remove_dir(dir) if File.exist?(dir)
end

def clean_current_dir
  clean_dir(File.join(current_dir, '.git'))
  clean_dir(File.join(current_dir, '.gitted'))
end

def create_fixture_repo(dir, repo_name = 'test_repo')
  fixture_dir = File.expand_path('../../../fixtures', __FILE__)

  FileUtils.cp_r(File.join(fixture_dir, repo_name, '.'), dir)

  Dir.chdir(dir) do
    File.rename('.gitted', '.git') if File.exist?('.gitted')
  end
end

Given(/^I'm in directory with repo$/) do
  clean_current_dir
  create_fixture_repo(current_dir)
end

Given(/^I'm in directory without repo$/) do
  clean_current_dir
end

Given(/^I'm in directory with repo "(.*?)"$/) do |repo|
  clean_current_dir
  create_fixture_repo(current_dir, repo)
end

Given(/^repo is in "(.*)" subdirectory$/) do |subdir|
  clean_current_dir
  dir = File.join(current_dir, subdir)
  FileUtils.mkdir_p(dir)
  create_fixture_repo(dir)
end
