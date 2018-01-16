class ImportSongsJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    Song.find_each do |s|
      s.destroy
    end
    File.open("/storage/karaoke/database.pipe.txt", "r").each_line do |line|
      data = line.split(/\|/)   
      s = Song.new
      s.title = data[0]
      s.file = data[1]
      s.singer1 = data[2]
      s.singer2 = data[3]
      s.singer3 = data[4]
      s.singer4 = data[5]
      s.number = data[1][0..3]
      if !s.save
        logger.error line
      end
    end
  end
end
