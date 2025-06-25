Map<String, dynamic> deepMapCast(Map<Object?, Object?> map) {
  final result = <String, dynamic>{};

  for (final entry in map.entries) {
    if (entry.value is Map<Object?, Object?>) {
      result[entry.key as String] =
          deepMapCast(entry.value as Map<Object?, Object?>);
    } else {
      result[entry.key as String] = entry.value;
    }
  }

  return result;
}
