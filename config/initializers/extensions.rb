Dir["#{Rails.root}/lib/core_ext/*.rb"].each {|file| require file }
Dir["#{Rails.root}/lib/spina/*.rb"].each {|file| require file }