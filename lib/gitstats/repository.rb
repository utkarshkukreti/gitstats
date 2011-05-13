module GitStats
  class Repository
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
  end
end
