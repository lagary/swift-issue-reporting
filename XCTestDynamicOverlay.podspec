Pod::Spec.new do |s|
  s.name             = 'XCTestDynamicOverlay'
  s.version          = '1.0.0'
  s.summary          = 'Dynamically available XCTest APIs for non-test targets'
  s.description      = <<-DESC
                       This library vends modules—XCTestDynamicOverlay and IssueReporting—for
                       making XCTest APIs dynamically available to non-test targets. This allows for
                       more powerful testing and debugging, including failure reporting from outside
                       your tests.
                       DESC
  s.homepage         = 'https://github.com/lagary/xctest-dynamic-overlay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Point-Free' => 'support@pointfree.co' }
  s.source           = { :git => 'https://github.com/lagary/xctest-dynamic-overlay.git', :tag => s.version.to_s }
  
  s.swift_version = '5.9'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  
  # Define subspecs for each component
  
  # IssueReporting spec
  s.subspec 'IssueReporting' do |issue|
    issue.source_files = 'Sources/IssueReporting/**/*'
  end
  
  # IssueReportingTestSupport spec (dynamic)
  s.subspec 'IssueReportingTestSupport' do |support|
    support.source_files = 'Sources/IssueReportingTestSupport/**/*'
    support.dependency 'XCTestDynamicOverlay/IssueReporting'
    
    # This is a test support module, so we should mark it as such
    support.framework = 'XCTest'
    support.pod_target_xcconfig = { 'ENABLE_TESTING_SEARCH_PATHS' => 'YES' }
    support.test_spec 'Tests' do |test_spec|
      test_spec.requires_app_host = true
    end
  end
  
  # XCTestDynamicOverlay spec (original module)
  s.subspec 'Core' do |core|
    core.source_files = 'Sources/XCTestDynamicOverlay/**/*'
    core.dependency 'XCTestDynamicOverlay/IssueReporting'
  end
  
  # Default to include the Core subspec
  s.default_subspec = 'Core'
end
