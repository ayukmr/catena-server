$LOAD_PATH.prepend(File.expand_path('./lib', __dir__))
require 'catena'

run Catena::App
