Pod::Spec.new do |s|
  s.name             = 'HHIBAN'
  s.version          = '1.0.1'
  s.summary          = 'Create and validate IBAN.'

  s.description      = <<-DESC
Create an IBAN out of a string (if it is a valid IBAN). If successful provides information as country (as ISO3166-1Alpha2) the check sum or just the value as formatted string. If you just need to know wether a string contains a valid IBAN you can use myString.isIBAN.
                       DESC

  s.homepage         = 'https://github.com/HHuckebein/IBAN'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HHuckebein' => 'development@berndrabe.de' }
  s.source           = { :git => 'https://github.com/HHuckebein/IBAN.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/HHIBAN/**/*.swift'
  s.swift_version = '4.1'
  s.dependency 'ISO3166_1Alpha2'
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/HHIBANTests/*.swift'
  end
end
