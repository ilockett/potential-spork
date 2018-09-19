Pod::Spec.new do |s|
  s.name             = 'ILTestFramework'
  s.version          = '1.0.1'
  s.summary          = 'A test framework'
  s.description      = <<-DESC
A test framework with files to install/configure an iMessage extension
                       DESC
  s.homepage         = 'https://github.com/ilockett/potential-spork'
  s.license          = 'MIT'
  s.author           = { 'Ian Lockett' => 'mail@ianlockett.co.uk' }

  s.ios.deployment_target = '10.0'
  s.preserve_paths  = 'install_imessage_extension.rb', 'greenfairy.framework', 'info.plist', 'Sources/*', 'LICENSE', 'README.md'
  s.script_phase = { :name => 'Install iMessage Target', :script => 'ruby ${PODS_TARGET_SRCROOT}/install_imessage_extension.rb "${SRCROOT}/../"' }
  s.source = { :http => 'https://github.com/ilockett/potential-spork/releases/download/1.0.1/greenfairy.zip' }

end
