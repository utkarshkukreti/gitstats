module GitStats
  class Commit
    attr_accessor :sha, :tree, :parents_sha, :author_name, :author_email, :author_time, :committer_name, :committer_email,
      :committer_time, :message, :timestamp
    def initialize(data)
      @sha = data.shift.split.last
      @tree = data.shift.split.last
      @parents_sha = []
      while data.first.start_with?("parent ")
        @parents_sha << data.shift.split.last
      end

      @author_name, @author_email, @author_time = data.shift.scan(/author (.*) <(.*)> (\d+)/)[0]
      @author_time = Time.at(@author_time.to_i)

      @committer_name, @committer_email, @committer_time = data.shift.scan(/committer (.*) <(.*)> (\d+)/)[0]
      @committer_time = Time.at(@committer_time.to_i)

      data.shift
      @message = []
      while data.first.start_with?("    ")
        @message << data.shift[4..-1]
      end
      @message = @message.join("\n")
      data.shift

    end
  end
end
