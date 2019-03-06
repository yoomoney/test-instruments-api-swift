Pod::Spec.new do |s|
    s.name         = 'YandexMoneyTestInstrumentsApi'
    s.version      = '1.2.5'
    s.homepage  = 'https://github.com/yandex-money/test-instruments-api-swift'
    s.license      = {
        :type => "MIT",
        :file => "LICENSE"
    }
    s.authors      = 'YandexMoney'
    s.summary      = 'Yandex Money Test Instruments Api iOS'

    s.source = {
        :git => 'https://github.com/yandex-money/test-instruments-api-swift.git',
        :tag => s.version.to_s
    }

    s.ios.deployment_target = '8.0'
    s.swift_version = '4.2'

    s.ios.source_files  = 'YandexMoneyTestInstrumentsApi/**/*.{h,swift}', 'YandexMoneyTestInstrumentsApi/*.{h,swift}'

    s.ios.framework = 'XCTest'
    s.ios.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }

    s.ios.dependency 'FunctionalSwift', '~> 1.1.0'
    s.ios.dependency 'YandexMoneyCoreApi', '~> 1.5.0'
    s.ios.dependency 'OHHTTPStubs', '~> 6.1.0'
end
