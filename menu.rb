class Menu
  def initialize
    @selection = -1
  end

  def display_menu_options
    puts '=============================================='
    puts 'Please make a selection:'
    puts '[1] Identify marketable population and material'
    puts '[2] Recommend tracks'
    puts '[3] List top sellers - by revenue'
    puts '[4] List top sellers - by volume'
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
    when 1..4
      selection
    when 0
      puts 'Goodbye!'
      exit(0)
    else
      puts 'Invalid option, please try again.'
    end
  end
end
