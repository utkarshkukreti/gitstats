module GitStats
  class CLI
    def initialize(argv)
      repo = Repository.new(argv.first || '.')
      puts "Your repo:\n#{repo.inspect}"
      puts "You have #{repo.commits.size} commits in your repository."
      puts "Here's the oldest one:\n#{repo.commits.first.inspect}"
      puts "and here's the latest one:\n#{repo.commits.last.inspect}"
    end
  end
end
