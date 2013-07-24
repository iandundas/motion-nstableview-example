class MainWindowController < NSWindowController
  attr_reader :window

  def window
    @window ||= Proc.new do
      w = NSWindow.alloc.initWithContentRect([[240, 180], [432, 295]],
        styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
        backing: NSBackingStoreBuffered,
        defer: false)
      w.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
      w.setMinSize(NSMakeSize(432, 261))
      w
    end.call
  end

  def init
    super
    window.orderFrontRegardless

    # produce some test data
    @column_one_data = ('a'..'z').to_a
    @column_two_data = []
    @column_one_data.count.times {|e| @column_two_data << e+1}

    init_views
    configure_views
    place_views
    constrain_views
    self
  end


  def init_views 

    @superview = @window.contentView

    @dictionary_of_views = {}
    @dictionary_of_views['scroll_view']= NSScrollView.alloc.init
    @dictionary_of_views['table_view']= NSTableView.alloc.init

    @dictionary_of_views.each do |key,subview| 
      self.instance_variable_set("@#{key}".to_sym, subview)
      subview.translatesAutoresizingMaskIntoConstraints = false
    end
  end

  def configure_views
    @scroll_view.setDocumentView @table_view
    @scroll_view.setHasVerticalScroller true

    @table_view.delegate=self
    @table_view.dataSource=self

    columnOne = NSTableColumn.alloc.initWithIdentifier "columnOne"
    columnOne.setWidth 200
    columnOne.identifier = :column_one
    @table_view.addTableColumn columnOne

    columnTwo = NSTableColumn.alloc.initWithIdentifier "columnTwo"
    columnTwo.setWidth 200
    columnTwo.identifier = :column_two
    @table_view.addTableColumn columnTwo

  end

  def place_views
    @scroll_view.documentView = @table_view

    @dictionary_of_views.each do |key,subview| 
      @superview.addSubview subview if subview.superview.nil? #check it's not in this array.
    end
  end

  def constrain_views
    @superview.addConstraints NSLayoutConstraint.constraintsWithVisualFormat("|[scroll_view]|", options:0, metrics: @metrics, views:@dictionary_of_views)
    @superview.addConstraints NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll_view]|", options:0, metrics: @metrics, views:@dictionary_of_views)

    @table_view.reloadData #important
  end



  ## TABLEVIEW DATASOURCE
  #########
  def numberOfRowsInTableView(table_view)
    @column_one_data.count
  end

  def tableView(table_view, objectValueForTableColumn:table_column, row:row)
    case table_column.identifier.to_sym
    when :column_one
      @column_one_data[row]
    when :column_two
      @column_two_data[row]
    end
  end




  ## TABLEVIEW DELEGATE
  #########

  def tableView(table_view, heightOfRow:row)
    25
  end

  def tableView(table_view, viewForTableColumn:tableColumn, row:row)
    @cell_identifier ||= "regular-cell"
    
    nstextfield_view = table_view.makeViewWithIdentifier(@cell_identifier, owner:self)

    if nstextfield_view.nil?
      nstextfield_view = NSTextField.alloc.initWithFrame CGRectZero
      nstextfield_view.identifier = @cell_identifier
    end

    return nstextfield_view
  end

end