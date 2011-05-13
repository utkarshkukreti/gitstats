module GitStats
  class Repository
    GIT_LOG_ARGS = '--numstat --pretty=format:"%H%n%P%n%aN <%ae>%n%cN <%ce>%n%ct%n%s%n%b%nENDOFOUTPUTGITMESSAGEHERE"'

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
        current = ""
        status = :new
        while input = io.gets
          status = :after_message if input == "ENDOFOUTPUTGITMESSAGEHERE\n"
          if status == :after_message && input == "\n"
            status = :new
            commits.unshift Commit.new(current)
            current = ""
          end
        end
      end
      commits
    end
  end
end
