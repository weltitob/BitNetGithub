import 'package:flutter/material.dart';


bool isCompleteJson(String data) {
  int braceCount = 0;
  bool isInString = false;
  for (int i = 0; i < data.length; i++) {
    // Toggle isInString flag when encountering a quote that is not escaped
    if (data[i] == '"' && (i == 0 || data[i - 1] != '\\')) {
      isInString = !isInString;
    }

    // Only count braces when not inside a string
    if (!isInString) {
      if (data[i] == '{') {
        braceCount++;
      } else if (data[i] == '}') {
        braceCount--;
        if (braceCount < 0) {
          // Found a closing brace before an opening brace
          return false;
        }
      }
    }
  }

  // Ensure all opened braces are closed and not currently in a string
  return braceCount == 0 && !isInString;
}