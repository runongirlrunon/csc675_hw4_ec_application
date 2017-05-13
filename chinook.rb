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
                "select A.AlbumId, A.Title \
                from Album A \
                where A.AlbumId in ( \
                  select T.AlbumId \
                  from Track T \
                  where T.TrackId in ( \
                    select L.TrackId \
                    from InvoiceLine L \
                    where L.InvoiceId \
                    not in ( \
                      select I.InvoiceId \
                      from Invoice I \
                      where I.BillingState = ?
                    )))
                group by A.AlbumId;",
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
                "",
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
