class Application
  def initialize
    @database = Chinook.new
    @menu = Menu.new
  end

  def run
    while true
      @menu.display_menu_options
      @menu.prompt_user_input
      user_choice = @menu.process_selection
      @database.handle(user_choice)
    end
  end
end
