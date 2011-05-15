module GitStats
  class Repository
    GIT_LOG_ARGS = '--numstat --pretty=raw'

    attr_reader :path

    def initialize(path)
      expanded_path = File.expand_path(path)

      unless File.directory?(expanded_path)
        raise "Invalid directory name: #{path}"
      end

      unless File.directory?(File.join(expanded_path, '.git')) 
        raise "Not a Git repository: #{path}"
      end

      @path = expanded_path
    end

    def commits
      @commits ||= load_commits
    end

    def load_commits
      commits = []
      IO.popen("cd #{@path} && git log #{GIT_LOG_ARGS}") do |io|
        current = []
        io.each_line do |line|
          if line.start_with?("commit ") && current.any?
            commits.unshift Commit.new(current)
            current = []
          end
          current << line.chomp
        end
        commits.unshift Commit.new(current)
      end
      commits
    end
  end
end
