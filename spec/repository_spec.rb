require 'spec_helper'

describe GitStats::Repository do
  context "invalid repository" do
    it "should raise exception if directory path is invalid" do
      expect { GitStats::Repository.new 'non_existent_directory' }.to raise_exception
    end

    it "should raise exception if directory path is not a git repository" do
      expect { GitStats::Repository.new File.dirname(__FILE__) }.to raise_exception
    end
  end

  context "valid repository" do
    before(:each) do
      @repo_path = File.expand_path(File.join(
        File.dirname(__FILE__), 'fixtures', 'repository'))
      @repo = GitStats::Repository.new @repo_path
    end

    it "should set the repo path" do
      @repo.path.should == @repo_path
    end

    it "should have commits" do
      @repo.commits.size.should == 3537
    end
  end
end
