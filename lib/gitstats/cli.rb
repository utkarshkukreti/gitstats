module GitStats
  class CLI
    def initialize(argv)
      parse_options(argv)
      render_templates
    end

    def parse_options(argv)
      @options = Slop.parse!(argv, :help => true) do
        on :f, 'force', 'Force replace output files'
        on :o, 'output', 'Output directory (defaults to ./output)', true, :default => './output'
        on :t, 'templates', 'Directory containing templates to render', true,
          :default => File.expand_path('../templates', __FILE__)
        on :v, 'version', 'Print version' do
          puts GitStats::VERSION
          exit
        end
      end
      @repository = Repository.new argv.first || '.'
    end

    def render_templates
      output_dir = File.expand_path(@options[:output])
      unless File.directory?(output_dir)
        puts "#{output_dir} doesn't exist. Creating."
        FileUtils.mkdir_p(output_dir)
      end

      templates = Dir[File.join(File.expand_path(@options[:templates]), '*.haml')]
      written = templates.count do |template|
        output = File.join(output_dir, "#{File.basename(template, 'haml')}html")
        render_template(template, output)
      end

      if written < templates.size
        puts "#{templates.size - written} file(s) were skipped. Call with '-f' to force overwrite."
      end
    end

    def render_template(input, output)
      if File.exist?(output)
        print "#{output} exists. "
        if @options.force?
          puts "Overwriting."
        else
          puts "Skipping."
          return false
        end
      else
        puts "Writing to #{output}"
      end

      locals = { commits: @repository.commits }
      rendered = Haml::Engine.new(File.read(input)).render(Object.new, locals)
      File.open(output, 'w') { |f| f << rendered }
    end
  end
end
