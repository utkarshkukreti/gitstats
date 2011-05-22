# GitStats

This gem allows you to generate statistics for any local git repository.
There are several pre defined templates that you can process, or you can
create your own templates in Haml.

## Getting Started

### Installing the gem

#### From RubyGems

    gem install gitstats

#### From Git repository

    git clone https://github.com/utkarshkukreti/gitstats.git
    cd gitstats
    rake install

## Usage

gitstats provides a command line utility `gitstats` that you can use to
generate the report.

Running just `gitstats` from inside the root of your git repository, will
generate all the default templates into `./output` directory.
    
You can specify a different git directory, or an output directory by using
the command line switches

    gitstats /var/repos/jquery              #  use git repo /var/repos/jquery
    gitstats -o ../output                   #  output to ../output
    gitstats /var/repos/jquery -o ../output #  combine the two

## License

MIT License. (c) 2011 Utkarsh Kukreti.

Originally built as a project for The Ruby Mendicant University.
