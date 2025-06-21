#!/usr/bin/env python3
"""
Script to replace imagewithtext.dart imports with glasscontainer.dart imports
across the entire BitNet Flutter project.
"""

import os
import re
import sys
from pathlib import Path

def find_dart_files(directory):
    """Find all .dart files in the given directory and subdirectories."""
    dart_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

def replace_import_in_file(file_path):
    """Replace imagewithtext import with glasscontainer import in a single file."""
    try:
        # Read the file
        with open(file_path, 'r', encoding='utf-8') as file:
            content = file.read()
        
        # Define the patterns
        old_import = "import 'package:bitnet/components/container/imagewithtext.dart';"
        new_import = "import 'package:bitnet/components/appstandards/glasscontainer.dart';"
        
        # Check if the old import exists
        if old_import in content:
            # Check if new import already exists
            if new_import not in content:
                # Replace the old import with the new one
                content = content.replace(old_import, new_import)
                
                # Write back to file
                with open(file_path, 'w', encoding='utf-8') as file:
                    file.write(content)
                
                print(f"✅ Replaced import in: {file_path}")
                return True
            else:
                # Remove the old import since new one already exists
                content = content.replace(old_import, '')
                
                # Write back to file
                with open(file_path, 'w', encoding='utf-8') as file:
                    file.write(content)
                
                print(f"🔄 Removed duplicate import in: {file_path}")
                return True
        
        return False
        
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
        return False

def main():
    """Main function to process all dart files."""
    # Get the project root directory
    if len(sys.argv) > 1:
        project_root = sys.argv[1]
    else:
        project_root = "/mnt/c/Users/tobia/StudioProjects/bitnet"
    
    if not os.path.exists(project_root):
        print(f"❌ Error: Directory {project_root} does not exist")
        return
    
    print(f"🔍 Searching for .dart files in: {project_root}")
    
    # Find all dart files
    dart_files = find_dart_files(project_root)
    
    if not dart_files:
        print("❌ No .dart files found!")
        return
    
    print(f"📁 Found {len(dart_files)} .dart files")
    
    # Process each file
    files_changed = 0
    files_processed = 0
    
    for file_path in dart_files:
        files_processed += 1
        if replace_import_in_file(file_path):
            files_changed += 1
    
    print(f"\n📊 Summary:")
    print(f"   Files processed: {files_processed}")
    print(f"   Files changed: {files_changed}")
    
    if files_changed > 0:
        print(f"\n✅ Successfully replaced imagewithtext.dart imports with glasscontainer.dart imports!")
        print(f"   Note: You may need to update any usage of ImageWithText widgets to use GlassContainer instead.")
    else:
        print(f"\n🔍 No files needed changes. All imports are already up to date!")

if __name__ == "__main__":
    main()