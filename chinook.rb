class Chinook
  def initialize
    @database = SQLite3::Database.new 'chinook.db'
  end

  def handle(user_choice)
    case user_choice.to_i
    when 1
      display_albums_from_artist
    when 2
      display_tracks_from_album
    when 3
      display_purchase_history_for_customer
    when 4
      update_track_price_single
    when 5
      update_track_price_batch
    else
      return
    end
  end

  def display_albums_from_artist
    puts "Enter artist name:"
    artist_name = sanitize(gets)
    results = @database.execute(
                "select B.Title from Album B where B.ArtistId in \
                (select A.ArtistId from Artist A where A.Name = ?);",
                artist_name)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def display_tracks_from_album
    puts "Enter album name:"
    album_name = sanitize(gets)
    results = @database.execute(
                "select T.Name from Track T where T.AlbumId in \
                (select A.AlbumId from Album A where A.Title = ?);",
                album_name)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def display_purchase_history_for_customer
    puts "Enter customer ID number:"
    customer_id = gets
    results = @database.execute(
                "select I.InvoiceDate, T.Name, L.UnitPrice, L.Quantity
                from Invoice I, InvoiceLine L, Track T
                where I.CustomerId = ?
                and L.TrackId = T.TrackId;",
                customer_id)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def update_track_price_single
    puts "Enter track ID number:"
    track_id = gets
    puts "The current unit price for this track is:"
    puts @database.execute("select UnitPrice from Track where TrackId = ?;", track_id)
    puts "Enter the new price (in dollars):"
    new_price = gets
    @database.execute("update Track set UnitPrice = ? where TrackId = ?;", new_price, track_id)
    puts "The new price has been updated to:"
    puts @database.execute("select UnitPrice from Track where TrackId = ?;", track_id)
    puts "\n\n"
  end

  def update_track_price_batch
    puts "Enter a percentage (from -100 to 100) to change all track prices:"
    percentage = gets / 100
    results = @database.execute("update Track set UnitPrice - UnitPrice * ? ", percentage)
    puts "Your update has been completed.\n\n"
  end

  def sanitize(input)
    input.split(" ").map {|word| word.capitalize}.join(" ")
  end
end
