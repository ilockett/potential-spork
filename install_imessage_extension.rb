#!/usr/bin/env ruby
require 'xcodeproj'
require 'json'
require 'set'

# Get project directory path from first argument and construct main project path
# project_dir = ARGV[0]

puts 'starting'

# if project_dir.to_s.strip.empty?
#   puts 'No project directory argument - exiting'
#   exit
# end
#
# project_search = project_dir + '*.xcodeproj'
# file = Dir[project_search].first
#
# if file.to_s.strip.empty?
#   puts 'No project found - exiting'
#   exit
# end
#
# # Open project
# puts 'Open project'
# project = Xcodeproj::Project.open(file)
#
# # Check targets to see if ours already exists
# puts 'Check targets to see if ours already exists'
# targets = []
# project.targets.each do |target|
#   targets.push(target.product_type)
# end
# if targets.uniq.length != targets.length
#   puts 'iMessage extension target already exists - exiting'
#   exit
# end
#
# # Get reference to the main app target
# puts 'Get reference to the main app target'
# app_target = project.targets.find { |t| t.product_type == 'com.apple.product-type.application' }
#
# # Create a new target for the iMessage extension
# puts 'Create a new target for the iMessage extension'
# target = project.new_target(:messages_extension, 'ILiMessage', :ios, '11.0')
#
# target.build_configurations.each do |configuration|
#   # Find the matching app configuration and its bundle identifier.
#   puts 'Find the matching app configuration and its bundle identifier.'
#   app_config = app_target.build_configurations.find { |bc| bc.name == configuration.name }
#   app_bundle_id = app_config.build_settings['PRODUCT_BUNDLE_IDENTIFIER']
#   app_bundle_id = '' if app_bundle_id.to_s.strip.empty?
#
#   # Update the new target.
#   puts 'Update the new target'
#   configuration.build_settings['PRODUCT_NAME'] = 'ILiMessage'
#   configuration.build_settings['INFOPLIST_FILE'] = Dir.pwd + '/Info.plist'
#   configuration.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = app_bundle_id + '.iMessage'
#   configuration.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = 'iMessage App Icon'
#   configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
#   configuration.build_settings['FRAMEWORK_SEARCH_PATHS'] = Dir.pwd
#   configuration.build_settings['LD_RUNPATH_SEARCH_PATHS'] = ['$(inherited)', '@executable_path/Frameworks', '@executable_path/../../Frameworks']
# end
#
# # Create a group for our extension files
# puts 'Create a group for our extension files'
# extension_group = project.new_group('ILiMessage')
#
# # Add the files to the group and compile sources build phase
# puts 'Add the files to the group and compile sources build phase'
# extension_dir = Dir[Dir.pwd + '/Sources/*']
# extension_dir.each do |filename|
#   unless File.directory?(filename)
#     file = extension_group.new_file(filename)
#     target.source_build_phase.add_file_reference(file)
#   end
# end
#
# # Reference the project frameworks group and our iMessage target frameworks build phase
# puts 'Reference the project frameworks group and our iMessage target frameworks build phase'
# framework_group = project.frameworks_group
# framework_build_phase = target.frameworks_build_phase
#
# # Add each framework to the group and build phase.
# puts 'Add each framework to the group and build phase'
# def fileRefForFramework(path, framework_group)
#   file_ref = framework_group.new_reference(path)
#   file_ref.source_tree = 'SOURCE_ROOT'
#   file_ref
# end
#
# custom_framework_ref = fileRefForFramework(Dir.pwd + '/ILTestFramework.framework', framework_group)
# messages_framework_ref = fileRefForFramework('System/Library/Frameworks/Messages.framework', framework_group)
# framework_build_phase.add_file_reference(custom_framework_ref)
# framework_build_phase.add_file_reference(messages_framework_ref)
#
# # Add the extension as a dependency of the main app.
# puts 'Add the extension as a dependency of the main app.'
# embed_extensions_phase = app_target.new_copy_files_build_phase('Copy files')
# embed_extensions_phase.symbol_dst_subfolder_spec = :plug_ins
# embed_extensions_phase.add_file_reference(target.product_reference)
# app_target.add_dependency(target)
#
# # Add an 'embed frameworks' build phase to ensure our framework is copied into bundle
# puts 'Add an embed frameworks build phase to ensure our framework is copied into bundle'
# embed_frameworks_build_phase = target.new_copy_files_build_phase('Embed Frameworks')
# embed_frameworks_build_phase.symbol_dst_subfolder_spec = :frameworks
# build_file = embed_frameworks_build_phase.add_file_reference(custom_framework_ref)
# build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy'] }
#
# project.save
