#
#  Be sure to run `pod spec lint WQSomeUIKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "WQSomeUIKit"
  s.version      = "1.0.6"
  s.summary      = "Usual collection"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC 
                      平常自己使用一些频率比较高得工具、控件的封装,后期使用的时候也不断维护、更新 
                    DESC

  s.homepage     = "https://github.com/wang68543/WQSomeUIKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "王强" => "wang68543@163.com" }
  # Or just: s.author    = "王强"
  # s.authors            = { "王强" => "wang68543@163.com" }
  # s.social_media_url   = "http://twitter.com/王强"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/wang68543/WQSomeUIKit.git", :tag => "#{s.version}" }
  s.requires_arc = true

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
# "WQSomeUIKit",  表示源文件的路径，注意这个路径是相对podspec文件而言的。
  s.source_files  = "WQSomeUIKit/**/**/*.{h,m}"
  # s.vendored_libraries = "WQSomeUIKit/Resources/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Resources/amrwapper/libopencore-amrwb.a"
  s.resources = ["WQSomeUIKit/Resources/Sb/*.storyboard"] 
  # s.exclude_files = "Classes/Exclude"
   #import "WQConstans.h"
#   s.prefix_header_contents =<<-EOS
#                             #import "WQCache.h"
#                             EOS
#   # s.public_header_files = 'WQSomeUIKit/*.h'


#   # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#   #
#   #  A list of resources included with the Pod. These are copied into the
#   #  target bundle with a build phase script. Anything else will be cleaned.
#   #  You can preserve files from being cleaned, please don't preserve
#   #  non-essential files like tests, examples and documentation.
#   #

#   # s.resource  = "icon.png"
#   # s.resources = "WQSomeUIKit/**/**/*.a"

#   # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


#   # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#   #
#   #  Link your library with frameworks, or libraries. Libraries do not include
#   #  the lib prefix of their name.
#   #

#   # s.framework  = "SomeFramework"
#   # s.frameworks = "SomeFramework", "AnotherFramework"
#   s.frameworks = 'Foundation','UIKit' 
#   # s.library   = "iconv"
#   # s.libraries = "iconv", "xml2"


#    s.subspec 'Gloable' do |ss|
#     # ss.source_files ="WQSomeUIKit/Gloable/**/*.{h,m}"
#     ss.subspec 'Header' do |sss|
#       sss.source_files = 'WQSomeUIKit/Gloable/Header/*.{h,m}'
#       sss.public_header_files='WQSomeUIKit/Gloable/Header/*.h'
#     end 
#   end

# # s.subspec 'Resources' do |ss|
# #     ss.subspec 'amrwapper' do |sss|
# #       sss.source_files = 'WQSomeUIKit/Resources/amrwapper/*.{h,m}'
# #       sss.requires_arc = false
# #       sss.vendored_libraries = "WQSomeUIKit/Resources/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Resources/amrwapper/libopencore-amrwb.a"
# #     end 
# #   end

#   #  s.subspec 'AnmationViews' do |ss|
#   #   ss.subspec 'Animation' do |sss|
#   #     sss.source_files = 'WQSomeUIKit/AnmationViews/Animation/*.{h,m}'
#   #   end 
#   # end

#    s.subspec 'Category' do |ss|
#     # ss.source_files = 'WQSomeUIKit/Category/**/*.{h,m}'
#     ss.subspec 'Category_Foundation' do |sss|
#       sss.source_files = 'WQSomeUIKit/Category/Category_Foundation/*.{h,m}'
#       sss.public_header_files = 'WQSomeUIKit/Category/Category_Foundation/*.h'
#     end 
#     ss.subspec 'Category_UIKit' do |sss|
#       sss.source_files = 'WQSomeUIKit/Category/Category_UIKit/*.{h,m}'
#     end  
#   end




#   s.subspec 'Tool' do |ss|
#     # ss.source_files = 'WQSomeUIKit/Tool/**/*.{h,m}'
#     ss.subspec 'BasicFoundation' do |sss|
#       sss.source_files = 'WQSomeUIKit/Tool/BasicFoundation/*.{h,m}'
#     end 
#     ss.subspec 'BasicHelp' do |sss|
#       sss.source_files = 'WQSomeUIKit/Tool/BasicHelp/*.{h,m}'
#       sss.public_header_files ='WQSomeUIKit/Tool/BasicHelp/*.h'
#     end
#     ss.subspec 'FunctionHelp' do |sss|
#       sss.source_files = 'WQSomeUIKit/Tool/FunctionHelp/*.{h,m}'
#     end
#     ss.subspec 'VoiceTool' do |sss|
#       sss.source_files = 'WQSomeUIKit/Tool/VoiceTool/*.{h,m}'
#     end
#   end


#   s.subspec 'UICustom' do |ss|
#     ss.source_files = 'WQSomeUIKit/UICustom/**/*.{h,m}'
#     ss.subspec 'ViewCustom' do |sss|
#       sss.source_files = 'WQSomeUIKit/UICustom/ViewCustom/*.{h,m}'
#     end 
#   end

   
#   s.subspec 'UIHelp' do |ss|
#     # ss.source_files = 'WQSomeUIKit/UIHelp/**/*.{h,m}'
#     ss.subspec 'Help' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/Help/*.{h,m}'
#       sss.public_header_files='WQSomeUIKit/UIHelp/Help/*.h'
#     end
#     # ss.subspec 'AlertUI' do |sss|
#     #   sss.source_files = 'WQSomeUIKit/UIHelp/AlertUI/*.{h,m}'
#     # end 
#     ss.subspec 'BannerLoop' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/BannerLoop/*.{h,m}'
#     end
#     ss.subspec 'ClendarUI' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/ClendarUI/*.{h,m}'
#     end
#     ss.subspec 'ExamineUI' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/ExamineUI/*.{h,m}'
#     end
#     ss.subspec 'FlowTagUI' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/FlowTagUI/*.{h,m}'
#     end 
#     # ss.subspec 'PhotoUI' do |sss|
#     #   sss.source_files = 'WQSomeUIKit/UIHelp/PhotoUI/*.{h,m}'
#     # end
#     ss.subspec 'PopSelectionsUI' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/PopSelectionsUI/*.{h,m}'
#     end
#     # ss.subspec 'ShareUI' do |sss|
#     #   sss.source_files = 'WQSomeUIKit/UIHelp/ShareUI/*.{h,m}'
#     # end
#     ss.subspec 'SlideMenu' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/SlideMenu/*.{h,m}'
#     end 
#     ss.subspec 'StarUI' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/StarUI/*.{h,m}'
#     end
#     ss.subspec 'VerticalLoopText' do |sss|
#       sss.source_files = 'WQSomeUIKit/UIHelp/VerticalLoopText/*.{h,m}'
#     end
#   end


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  
  non_arc_files = 'WQSomeUIKit/Tool/VoiceTool/amrwapper/*.{h,m}'
   s.requires_arc = true
   s.exclude_files = non_arc_files
   s.subspec 'WavAmrHelp' do |sna|
   sna.requires_arc = false
   sna.source_files = non_arc_files
   # sna.resources =
   sna.vendored_libraries = "WQSomeUIKit/Tool/VoiceTool/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Tool/VoiceTool/amrwapper/libopencore-amrwb.a"
   end
   # $(PROJECT_DIR)/WQSomeUIKit/Resources/amrwapper/opencore-amrwb
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'AFNetworking', '~> 3.0'

end
