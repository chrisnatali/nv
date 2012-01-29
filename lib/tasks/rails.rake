desc "Checks app and warns of deprecated code."
task :deprecated => :environment do
  deprecated = {
    '@params'    => 'Use params[] instead',
    '@session'   => 'Use session[] instead', 
    '@flash'     => 'Use flash[] instead',
    '@request'   => 'Use request[] instead',
    '@env'       => 'Use env[] instead',
    'find_all'   => 'Use find(:all) instead',
    'find_first' => 'Use find(:first) instead',
    'render_partial' => 'User render :partial instead',
    'component'  => 'Use of components are bad',
    'paginate'   => 'Default paginator is slow',
    'start_form_tag' => 'Use form_for instead',
    'end_form_tag' => 'User form_for instead',
    ':post => true' => 'Use :method => :post instead'
  }

  deprecated.each do |key, warning|
    puts '--> ' + key
    output = `cd '#{File.expand_path('app', RAILS_ROOT)}' && grep -n --exclude=*.svn* -r '#{key}' *`
    unless output =~ /^$/
      puts "  !! " + warning + " !!"
      puts '  ' + '.' * (warning.length + 6)
      puts output
    else
      puts " Clean!  Cheers!"
    end
    puts
  end
end
