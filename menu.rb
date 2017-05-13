class Menu
  def initialize
    @selection = -1
  end

  def display_menu_options
    puts '=============================================='
    puts 'Please make a selection:'
    puts '[1] Obtain Album title(s) based on Artist name'
    puts '[2] Obtain Track(s) of an Album title'
    puts '[3] Purchase History for a Customer'
    puts '[4] Update Track Price - Individual'
    puts '[5] Update Track Price - Batch'
    puts '[0] Exit program'
    puts '=============================================='
    puts
  end

  def prompt_user_input
    @selection = gets
  end

  def selection
    @selection
  end

  def process_selection
    case @selection.to_i
    when 1..5
      selection
    when 0
      puts 'Goodbye!'
      exit(0)
    else
      puts 'Invalid option, please try again.'
    end
  end
end
