String correctEncoding(String text) {
  try {
    // Handle common character encoding issues
    // Handle common character encoding issues
    String correctedText = text
        .replaceAll('â€˜', '‘')
        .replaceAll('â€™', '’')
        .replaceAll('â€œ', '“')
        .replaceAll('â€', '”')
        .replaceAll('â€“', '–')
        .replaceAll('â€”', '—')
        .replaceAll('â€¦', '…')
        .replaceAll('â‚¬', '€')
        .replaceAll('â‚£', '£')
        .replaceAll('â‚¥', '¥')
        .replaceAll('â€¢', '•')
        .replaceAll('â„¢', '™')
        .replaceAll('âš¡', '⚡');

    return correctedText;
  } catch (e) {
    return "Could not decode data: $text";
  }
}