# RubyMotion OSX NSTableView example 
#### (using AutoLayout)

I struggled a little to get a basic NSTableView working in RubyMotion, coming from an iOS background, as I couldn't find any conclusive 'hello world'-esque examples. So, here's mine.

It's also useful to see how to create your first window, as the difference between NSViewController and NSWindowController isn't immediately obvious either. There's a [helpful explanation of this](http://stackoverflow.com/a/10128268/349364) on StackOverflow.

Once I'd got it working, I converted it to use AutoLayout. Note the sequence that I use to setup AutoLayout: 

    init_views
    configure_views
    place_views
    constrain_views
    
I find this sequence helps categorise what can be a complicated setup (if it were a more complicated controller, at least).