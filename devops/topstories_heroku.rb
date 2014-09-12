require "feedjira"
require "date"
require "pg"
require "active_support/all"

conn = PG.connect(
        :host => 'ec2-54-204-40-96.compute-1.amazonaws.com',
        :dbname => 'd8mb17g883jqhh',
        :user => 'zwqaqdrugekjys',
        :password => 'AKhWFcOHMwL3C14gXO-xG-Ld0l')

conn.prepare("insert_entry", "insert into topstories (entry_id) values ($1)")

conn.exec("delete from topstories")
conn.exec( "SELECT title,id,url,updated_at FROM feeds" ) do |result|
  result.each do |url|
    if url["title"] == 'Engadget' || url["title"] == 'Arstechnica' || url["title"] == 'U.S. News' || url["title"] == 'Polygon' || url["title"] == 'CNN' || url["title"] == 'Joystiq' || url["title"] == 'BBC' || url["title"] == 'Gizmodo' || url["title"] == 'Lifehacker'

      feedid = url["id"]
      conn.exec( "SELECT id FROM entries where feed_id = #{feedid} order by id desc limit 1" ) do |entry|
        entry.each do |story|
          conn.exec_prepared("insert_entry", [story["id"]])
        end
      end
    end
  end
end
conn.close
