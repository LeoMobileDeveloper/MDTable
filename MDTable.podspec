Pod::Spec.new do |s|
  s.name             = 'MDTable'
  s.version          = '0.2.0'
  s.summary          = 'Elegant way to write tableView in Swift'
  s.description      = <<-DESC
A simple but power wrapper of UITableView to create model-driven TableView.
                       DESC

  s.homepage         = 'https://github.com/LeoMobileDeveloper/MDTable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leo' => 'leomobiledeveloper@gmail.com' }
  s.source           = { :git => 'https://github.com/LeoMobileDeveloper/MDTable.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/**/*'
end

