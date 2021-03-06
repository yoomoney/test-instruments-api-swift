Pod::Spec.new do |s|
    s.name         = 'YooMoneyTestInstrumentsApi'
    s.version      = '2.0.0'
    s.homepage  = 'https://github.com/yoomoney/test-instruments-api-swift'
    s.license      = {
        :type => "MIT",
        :file => "LICENSE"
    }
    s.authors      = 'YooMoney'
    s.summary      = 'YooMoney Test Instruments Api iOS'

    s.source = {
        :git => 'https://github.com/yoomoney/test-instruments-api-swift.git',
        :tag => s.version.to_s
    }

    s.ios.deployment_target = '8.0'
    s.swift_version = '5.0'

    s.ios.source_files  = 'YooMoneyTestInstrumentsApi/**/*.{h,swift}', 'YooMoneyTestInstrumentsApi/*.{h,swift}'

    s.ios.framework = 'XCTest'
    s.ios.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }

    s.ios.dependency 'FunctionalSwift', '~> 1.2.0'
    s.ios.dependency 'YooMoneyCoreApi', '~> 1.9.0'
    s.ios.dependency 'OHHTTPStubs', '~> 8.0.0'
end
