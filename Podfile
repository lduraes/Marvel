# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!

plugin 'cocoapods-keys',
       project: 'Marvel',
       target: 'Marvel',
       keys: [
         'MarvelAPIPublicKey',
         'MarvelAPIPrivateKey',
       ]

target 'Marvel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Marvel
  pod 'CryptoSwift'
  pod 'SDWebImage', :modular_headers => true
  pod 'SwiftLint'
  pod 'SwiftSpinner'
  
  target 'MarvelTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
