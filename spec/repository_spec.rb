require 'spec_helper'

describe GitStats::Repository do
  context "invalid repository" do
    it "should raise exception if directory path is invalid" do
      expect { Repository.new 'non_existent_directory' }.to raise_exception
    end

    it "should raise exception if directory path is not a git repository" do
      expect { Repository.new File.dirname(__FILE__) }.to raise_exception
    end
  end

  context "valid repository" do
    before(:each) do
      @repo_path = File.expand_path(File.join(
        File.dirname(__FILE__), 'fixtures', 'repository'))
      @repo = Repository.new @repo_path
    end

    it "should set the repo path" do
      @repo.path.should == @repo_path
    end
  end
end
