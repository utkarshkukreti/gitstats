module GitStats
  class CLI
    def initialize(argv)
      options = Slop.parse!(argv, :help => true) do
        on :f, 'force', 'Force replace output files'
        on :o, 'output', 'Output directory (defaults to ./output)', true, :default => './output'
      end
      # create output dir if it doesn't exist
      output_dir = File.expand_path(options[:output])
      unless File.directory?(output_dir)
        puts "#{output_dir} doesn't exist. Creating."
        FileUtils.mkdir_p(output_dir)
      end
      repo = Repository.new(argv.first || '.')
      locals = { commits: repo.commits }
      skipped_files = 0

      Dir[File.expand_path('../templates/*.haml', __FILE__)].each do |template|
        rendered = Haml::Engine.new(File.read(template)).render(Object.new, locals)
        output_file = File.join(output_dir, File.basename(template).gsub(/haml$/, 'html'))
        if File.exist?(output_file)
          print "#{output_file} exists. "
          if options.force?
            puts "Overwriting."
            File.open(output_file, 'w') { |f| f << rendered }
          else
            puts "Skipping."
            skipped_files += 1
          end
        else
          puts "Writing to #{output_file}"
          File.open(output_file, 'w') { |f| f << rendered }
        end
      end

      if skipped_files > 0
        puts "#{skipped_files} files were skipped. Call with '-f' to force overwrite."
      end
    end
  end
end
