require 'spec_helper'

describe GitStats::Commit do
  # before(:all) as this is pretty heavy
  before(:all) do
    @repo_path = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'repository'))
    @repo = GitStats::Repository.new @repo_path
  end

  context "commit" do
    subject { @repo.commits.first }

    its(:sha)             { should == "8a4a1edf047f2c272f663866eb7b5fcd644d65b3" }
    its(:tree)            { should == "44fa7baa51630e8ca0bb964c30aad224b4356f68" }
    its(:parents_sha)     { should == []                                         }
    its(:author_name)     { should == "John Resig"                               }
    its(:author_email)    { should == "jeresig@gmail.com"                        }
    its(:author_time)     { should == Time.at(1142998387)                        }
    its(:committer_name)  { should == "John Resig"                               }
    its(:committer_email) { should == "jeresig@gmail.com"                        }
    its(:committer_time)  { should == Time.at(1142998387)                        }
    its(:message)         { should == "Inital Import."                           }
  end
end
