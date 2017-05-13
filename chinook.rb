class Chinook
  def initialize
    @database = SQLite3::Database.new 'chinook.db'
  end

  def handle(user_choice)
    case user_choice.to_i
    when 1
      identify_marketing
    when 2
      recommend_tracks
    when 3
      list_top_sellers_by_revenue
    when 4
      list_top_sellers_by_volume
    else
      return
    end
  end

  def identify_marketing
    puts "Enter state (postal abbreviation):"
    state = gets
    puts "Marketing material:"
    results = @database.execute(
                "with AllAlbums AS \
                  ( select A.AlbumId, A.Title \
                    from album A \
                    order by A.AlbumId ), \
                StateAlbums as \
                  ( select A.AlbumId, A.Title \
                    from Track T, Invoice I, InvoiceLine L, Album A \
                    where L.TrackId = T.TrackId \
                    and A.AlbumId = T.AlbumId \
                    and L.InvoiceId = I.InvoiceId \
                    and I.BillingState = ? \
                    group by A.Title \
                    order by A.AlbumId) \
                select * from AllAlbums \
                except \
                select * from StateAlbums;",
                state)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end

    puts "Marketable customers:"
    results = @database.execute(
                "select * \
                from Customer C \
                where C.State = ?",
                state)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def recommend_tracks
    puts "Enter customer ID number:"
    customer_id = gets
    results = @database.execute(
                "select T.AlbumId, group_concat(T.TrackId) as 'AlbumTracks' \
                from Track T, InvoiceLine L, Invoice I \
                where L.InvoiceId = I.InvoiceId and I.CustomerId = ? \
                and T.TrackId = L.TrackId \
                group by T.AlbumId \
                having count(T.AlbumId)>=3",
                customer_id)
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def list_top_sellers_by_revenue
    results = @database.execute(
                "")
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end

  def list_top_sellers_by_volume
    results = @database.execute(
                "")
    unless results.empty?
      puts results
    else
      puts "No results returned.\n\n"
    end
  end
end
