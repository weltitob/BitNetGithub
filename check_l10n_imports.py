#!/usr/bin/env python3
import os
import re

def check_file_for_missing_import(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check if file uses L10n.of(context)
        if 'L10n.of(context)' not in content:
            return False, "No L10n usage"
        
        # Check if file has the import
        if "import 'package:bitnet/intl/generated/l10n.dart';" in content:
            return False, "Import already exists"
        
        return True, "Missing import"
    
    except Exception as e:
        return False, f"Error: {e}"

def find_dart_files(directory):
    dart_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))
    return dart_files

# Find all dart files in lib directory
lib_dir = '/mnt/c/Users/tobia/StudioProjects/bitnet/lib'
dart_files = find_dart_files(lib_dir)

missing_import_files = []

for file_path in dart_files:
    needs_import, reason = check_file_for_missing_import(file_path)
    if needs_import:
        missing_import_files.append(file_path)
        print(f"MISSING: {file_path}")

print(f"\nTotal files missing L10n import: {len(missing_import_files)}")
for file_path in missing_import_files:
    print(file_path)