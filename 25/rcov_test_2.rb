puts 'starting'
def do_something(something)
  if something == 'branch'
    puts 'true'
  else
    puts 'false'
  end
end
do_something 'branch'
do_something 'do_not_branch'
puts 'all done'

