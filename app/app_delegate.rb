class AppDelegate
  def applicationDidFinishLaunching(notification)

    buildMenu

    # Builds it's own window in `init` and displays it
    @controller = MainWindowController.alloc.init
  end
end
