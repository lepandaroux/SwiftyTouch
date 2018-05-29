Pod::Spec.new do |s|

    s.name                  = 'SwiftyTouch'
    s.version               = '0.1'
    s.summary	            = 'Swift Kit for Cocoa Touch'
    s.description           = <<-DESC
Kit of various tools dedicated to iOS development.
                              DESC
    s.homepage              = 'https://github.com/lepandaroux/SwiftyTouch.git'
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.author                = 'LEPandaRouX'
    s.source                = { :git => 'https://github.com/lepandaroux/SwiftyTouch.git', :tag => s.version.to_s }

    s.requires_arc          = true

    s.ios.deployment_target = '10.0'

    s.swift_version = '4.1'

    s.source_files = 'SwiftyTouch/**/*.{swift}'
end
