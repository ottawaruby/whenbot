# Rails doesn't autoload files that contain classes or modules that
# have already been defined (i.e. when you try and re-open a class
# or module). We'll be doing a bunch of that here, so we'll 
# manually require the files in the lib folder, along with
# its subfolders.
#
# This is also required to load the Triggers and Actions for
# automatic detection of Triggers/Actions after a Channel is
# added.

# Solution from here: 
#   - http://stackoverflow.com/a/3181988/321896
# and 
#  - http://stackoverflow.com/a/6797707/321896

Dir[Rails.root + 'lib/**/*.rb'].each do |file|
  require file
end