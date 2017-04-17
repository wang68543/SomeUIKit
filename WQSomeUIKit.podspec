

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "WQSomeUIKit"
  s.version      = "1.1.7"
  s.summary      = "Usual collection"

  s.description  = <<-DESC 
                      平常自己使用一些频率比较高得工具、控件的封装,后期使用的时候也不断维护、更新 
                    DESC

  s.homepage     = "https://github.com/wang68543/WQSomeUIKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.author             = { "王强" => "wang68543@163.com" }
  # Or just: s.author    = "王强"
  # s.authors            = { "王强" => "wang68543@163.com" }
  # s.social_media_url   = "http://twitter.com/王强"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/wang68543/WQSomeUIKit.git", :tag => "#{s.version}" }
  s.requires_arc = true

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

# "WQSomeUIKit",  表示源文件的路径，注意这个路径是相对podspec文件而言的。
  # s.source_files  = "WQSomeUIKit/**/**/*.{h,m}"
  # s.source_files = "WQSomeUIKit/**/**/*.{h,m}"
  # s.public_header_files = 'WQSomeUIKit/WQSomeUIKit.h'
  # s.vendored_libraries = "WQSomeUIKit/Resources/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Resources/amrwapper/libopencore-amrwb.a"
  s.resources = ["WQSomeUIKit/Resources/Sb/*.storyboard"] 
  # s.exclude_files = "Classes/Exclude"
   #import "WQConstans.h"
#   s.prefix_header_contents =<<-EOS
#                             #import "WQCache.h"
#                             EOS
#   # s.public_header_files = 'WQSomeUIKit/*.h'


#   # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

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


   s.subspec 'Gloable' do |ss|
    # ss.source_files ="WQSomeUIKit/Gloable/**/*.{h,m}"
    ss.subspec 'Header' do |sss|
      sss.source_files = 'WQSomeUIKit/Gloable/Header/*.{h,m}'
      sss.public_header_files='WQSomeUIKit/Gloable/Header/*.h'
    end 
  end

# s.subspec 'Resources' do |ss|
#     ss.subspec 'amrwapper' do |sss|
#       sss.source_files = 'WQSomeUIKit/Resources/amrwapper/*.{h,m}'
#       sss.requires_arc = false
#       sss.vendored_libraries = "WQSomeUIKit/Resources/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Resources/amrwapper/libopencore-amrwb.a"
#     end 
#   end

   s.subspec 'AnmationViews' do |ss|
    ss.subspec 'Animation' do |sss|
      sss.source_files = 'WQSomeUIKit/AnmationViews/Animation/*.{h,m}'
    end 
  end

   s.subspec 'Category' do |ss|
    # ss.source_files = 'WQSomeUIKit/Category/**/*.{h,m}'
    
    ss.subspec 'Category_Vendor' do |sss|

      sss.source_files = 'WQSomeUIKit/Category/Category_Vendor/*.{h,m}'
    end 
    ss.subspec 'Category_Foundation' do |sss|
      sss.dependency 'WQSomeUIKit/Category/Category_Vendor'
      sss.source_files = 'WQSomeUIKit/Category/Category_Foundation/*.{h,m}'
      sss.public_header_files = 'WQSomeUIKit/Category/Category_Foundation/*.h'
    end 
    ss.subspec 'Category_UIKit' do |sss|
      sss.dependency 'WQSomeUIKit/Gloable/Header'
      sss.source_files = 'WQSomeUIKit/Category/Category_UIKit/*.{h,m}'
    end  
  end


   non_arc_files = 'WQSomeUIKit/Tool/VoiceTool/amrwapper/*.{h,m}'
   s.requires_arc = true
   s.exclude_files = non_arc_files
   s.subspec 'WavAmrHelp' do |sna|
   sna.requires_arc = false
   sna.source_files = non_arc_files
   # sna.resources =
   sna.vendored_libraries = "WQSomeUIKit/Tool/VoiceTool/amrwapper/libopencore-amrnb.a","WQSomeUIKit/Tool/VoiceTool/amrwapper/libopencore-amrwb.a"
   end

  s.subspec 'Tool' do |ss|
    # ss.source_files = 'WQSomeUIKit/Tool/**/*.{h,m}'
    ss.subspec 'BasicFoundation' do |sss|
      sss.source_files = 'WQSomeUIKit/Tool/BasicFoundation/*.{h,m}'
    end 
    ss.subspec 'BasicHelp' do |sss|
      sss.source_files = 'WQSomeUIKit/Tool/BasicHelp/*.{h,m}'
      sss.public_header_files ='WQSomeUIKit/Tool/BasicHelp/*.h'
    end
    ss.subspec 'FunctionHelp' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/Tool/FunctionHelp/*.{h,m}'
    end
    ss.subspec 'NetWorkTool' do |sss|
      sss.dependency 'WQSomeUIKit/Tool/BasicHelp'
      sss.dependency 'WQSomeUIKit/Category/Category_UIKit'
      sss.source_files = 'WQSomeUIKit/Tool/NetWorkTool/*.{h,m}'
    end
    ss.subspec 'VoiceTool' do |sss|
      sss.dependency 'WQSomeUIKit/Tool/NetWorkTool'
      sss.dependency 'WQSomeUIKit/WavAmrHelp'
      sss.source_files = 'WQSomeUIKit/Tool/VoiceTool/*.{h,m}'
    end
    
  end


  s.subspec 'UICustom' do |ss|
    ss.subspec 'ViewCustom' do |sss|
      sss.source_files = 'WQSomeUIKit/UICustom/ViewCustom/*.{h,m}'
    end 
  end

   
  s.subspec 'UIHelp' do |ss|
    # ss.source_files = 'WQSomeUIKit/UIHelp/**/*.{h,m}'
    ss.subspec 'Help' do |sss|
      sss.source_files = 'WQSomeUIKit/UIHelp/Help/*.{h,m}'
      sss.public_header_files='WQSomeUIKit/UIHelp/Help/*.h'
    end
    ss.subspec 'AlertUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/AlertUI/*.{h,m}'
    end 
    ss.subspec 'BannerLoop' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/BannerLoop/*.{h,m}'
    end
    ss.subspec 'ClendarUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/ClendarUI/*.{h,m}'
    end
    ss.subspec 'ExamineUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/ExamineUI/*.{h,m}'
    end
    ss.subspec 'FlowTagUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/FlowTagUI/*.{h,m}'
    end 
    ss.subspec 'PhotoUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/PhotoUI/*.{h,m}'
    end
    ss.subspec 'PopSelectionsUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/PopSelectionsUI/*.{h,m}'
    end
    ss.subspec 'ShareUI' do |sss|
      sss.dependency 'WQSomeUIKit/UIHelp/Help'
      sss.source_files = 'WQSomeUIKit/UIHelp/ShareUI/*.{h,m}'
    end
    ss.subspec 'SlideMenu' do |sss|
      sss.source_files = 'WQSomeUIKit/UIHelp/SlideMenu/*.{h,m}'
    end 
    ss.subspec 'StarUI' do |sss|
      sss.source_files = 'WQSomeUIKit/UIHelp/StarUI/*.{h,m}'
    end
    ss.subspec 'VerticalLoopText' do |sss|
      sss.source_files = 'WQSomeUIKit/UIHelp/VerticalLoopText/*.{h,m}'
    end
  end


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  
   
   # $(PROJECT_DIR)/WQSomeUIKit/Resources/amrwapper/opencore-amrwb
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'SDWebImage', '~>3.8'

end
