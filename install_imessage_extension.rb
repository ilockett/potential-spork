#!/usr/bin/env ruby
require "xcodeproj"
require "json"
require "set"


# Get project directory path
puts 'start'
project_dir = ARGV[0]
project_search =  project_dir + '*.xcodeproj'
file = Dir[project_search].first
puts file
puts 'end'

 # path_to_project = "${SRCROOT}/${PROJECT_NAME}.xcodeproj"
 project = Xcodeproj::Project.open(file)
#
# # project_path="./platforms/ios/Huggg.xcodeproj"
# # project = Xcodeproj::Project.open(project_path)
#
targets = [];

project.targets.each do |target|
    targets.push(target.product_type)
end

if targets.uniq.length != targets.length
    puts "iMessage project already exists"
    return
end
#
target = project.new_target(:messages_extension, 'Huggg Imessage', :ios, "10.0")
#
# target.build_configurations.each do |configuration|
#     configuration.build_settings['SWIFT_VERSION'] = '4.1'
#     configuration.build_settings['PRODUCT_NAME'] = "Huggg iMessage";
#     configuration.build_settings['INFOPLIST_FILE'] = 'Huggg iMessage/Info.plist'
#     configuration.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = config['IMESSAGE_BUNDLE_ID']
#     configuration.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = 'iMessage App Icon'
#     configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.2'
# end
# #
# # build_phase = target.frameworks_build_phase
# #
# # # Remove founddation from build phase
# # build_phase.remove_file_reference(build_phase.files_references[0])
# #
# #
# # group = project.new_group('Huggg Imessage')
# #
# # # @todo make this less vague if it errors
# # FileUtils.cp_r Dir.pwd + '/submodules/huggg-imessage/src/', Dir.pwd + '/platforms/ios/Huggg Imessage'
# # my_dir = Dir[Dir.pwd + "/platforms/ios/Huggg Imessage/**/*.swift"]
# #
# # my_dir.each do |filename|
# #     puts filename
# #     if !File.directory?(filename)
# #         file = group.new_file(filename)
# #         target.source_build_phase.add_file_reference(file)
# #     end
# # end
# #
# # assets = group.new_file(Dir.pwd + "/platforms/ios/Huggg Imessage/Resources/Assets.xcassets")
# # storyboard = group.new_file(Dir.pwd + "/platforms/ios/Huggg Imessage/Resources/MainInterface.storyboard")
# #     target.add_resources([assets, storyboard])
# #
# # my_dir = Dir[Dir.pwd + "/platforms/ios/Huggg Imessage/Resources/UI/*",
# #              Dir.pwd + "/platforms/ios/Huggg Imessage/Resources/Fonts/*",
# #              Dir.pwd + "/ios/Huggg Imessage/Resources/*"]
# #
# # my_dir.each do |filename|
# #     file = group.new_file(filename)
# #     target.add_resources([file])
# # end
# #
# # #Add Messages Framework
# # framework_group = project.frameworks_group
# # path = "System/Library/Frameworks/Messages.framework"
# # file_ref = framework_group.new_reference(path)
# # file_ref.name = "Messages.framework"
# # file_ref.source_tree = 'SDKROOT'
# # build_file = build_phase.add_file_reference(file_ref)
# #
# # project.save();
# #
# # message_reference = project.targets.find { |t| t.product_type == 'com.apple.product-type.app-extension.messages'}
# # app_reference     = project.targets.find { |t| t.product_type == 'com.apple.product-type.application'}
# #
# # embed_extensions_phase = app_reference.new_copy_files_build_phase('Copy files')
# # embed_extensions_phase.symbol_dst_subfolder_spec = :plug_ins
# #
# #
# # embed_extensions_phase.add_file_reference(message_reference.product_reference)
# # app_reference.add_dependency(message_reference);
# #
# #
# # # Team
# # project.targets.each do |target|
# #     uuid = target && target.uuid
# #     target_atts_obj = project.root_object.attributes['TargetAttributes']
# # end
#
#
# puts "Added Huggg IMessage To Cordova Project"
#
project.save();
