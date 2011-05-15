require 'spec_helper'

describe GitStats::Commit do
  # before(:all) as this is pretty heavy
  before(:all) do
    @repo_path = File.expand_path(File.join(
      File.dirname(__FILE__), 'fixtures', 'repository'))
    @repo = GitStats::Repository.new @repo_path
  end

  it "should set some properties correctly" do
    commit = @repo.commits.first

    commit.sha.should == "8a4a1edf047f2c272f663866eb7b5fcd644d65b3"
    commit.tree.should == "44fa7baa51630e8ca0bb964c30aad224b4356f68"
    commit.parents_sha.should == []

    commit.author_name.should == "John Resig"
    commit.author_email.should == "jeresig@gmail.com"
    commit.author_time.should == Time.at(1142998387)

    commit.committer_name.should == "John Resig"
    commit.committer_email.should == "jeresig@gmail.com"
    commit.committer_time.should == Time.at(1142998387)

    commit.message.should == "Inital Import."

  end
end
