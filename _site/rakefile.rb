namespace :wczg do

  desc "Compile site"
  task :compile do
    puts `nanoc compile && cp -r output/* ../`
  end
end

