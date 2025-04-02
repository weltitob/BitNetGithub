import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

/// A helper class for implementing JSON-LD structured data in the BitNet app
class StructuredData extends StatelessWidget {
  final Widget child;
  final Map<String, dynamic> jsonLdData;

  const StructuredData({
    Key? key,
    required this.child,
    required this.jsonLdData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only apply structured data on web platform
    if (!kIsWeb) {
      return child;
    }

    // Format the JSON-LD data with proper escaping
    final String jsonLdString = _formatJsonLd(jsonLdData);

    // Use the SEO package to inject the structured data
    return Seo.data(
      data: jsonLdString,
      child: child,
    );
  }

  /// Formats a Map into a valid JSON-LD string
  String _formatJsonLd(Map<String, dynamic> data) {
    // Add the required @context field if not present
    if (!data.containsKey('@context')) {
      data = {
        '@context': 'https://schema.org',
        ...data,
      };
    }

    // Convert to JSON with proper escaping
    String jsonString = _mapToJsonString(data);
    
    // Wrap in script tags for JSON-LD
    return '<script type="application/ld+json">$jsonString</script>';
  }

  /// Converts a map to a JSON string with proper escaping
  String _mapToJsonString(Map<String, dynamic> map) {
    final StringBuffer buffer = StringBuffer();
    buffer.write('{');
    
    bool isFirst = true;
    map.forEach((key, value) {
      if (!isFirst) {
        buffer.write(',');
      }
      isFirst = false;
      
      buffer.write('"$key":');
      buffer.write(_valueToJsonString(value));
    });
    
    buffer.write('}');
    return buffer.toString();
  }

  /// Converts a value to a JSON string component with proper escaping
  dynamic _valueToJsonString(dynamic value) {
    if (value == null) {
      return 'null';
    } else if (value is String) {
      // Escape special characters
      final escaped = value
          .replaceAll('\\', '\\\\')
          .replaceAll('"', '\\"')
          .replaceAll('\n', '\\n')
          .replaceAll('\r', '\\r')
          .replaceAll('\t', '\\t');
      return '"$escaped"';
    } else if (value is num || value is bool) {
      return value.toString();
    } else if (value is List) {
      final StringBuffer buffer = StringBuffer();
      buffer.write('[');
      
      bool isFirst = true;
      for (var item in value) {
        if (!isFirst) {
          buffer.write(',');
        }
        isFirst = false;
        
        buffer.write(_valueToJsonString(item));
      }
      
      buffer.write(']');
      return buffer.toString();
    } else if (value is Map) {
      return _mapToJsonString(value.cast<String, dynamic>());
    } else {
      // Convert to string if not a standard JSON type
      return '"${value.toString()}"';
    }
  }

  /// Create Organization structured data
  static Map<String, dynamic> organization({
    required String name,
    required String url,
    String? logo,
    String? description,
    List<String>? sameAs,
  }) {
    return {
      '@type': 'Organization',
      'name': name,
      'url': url,
      if (logo != null) 'logo': logo,
      if (description != null) 'description': description,
      if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
    };
  }

  /// Create WebSite structured data
  static Map<String, dynamic> website({
    required String name,
    required String url,
    String? description,
    String? author,
  }) {
    return {
      '@type': 'WebSite',
      'name': name,
      'url': url,
      if (description != null) 'description': description,
      if (author != null) 'author': {'@type': 'Organization', 'name': author},
    };
  }

  /// Create WebPage structured data
  static Map<String, dynamic> webPage({
    required String name,
    required String url,
    String? description,
    DateTime? datePublished,
    DateTime? dateModified,
    String? image,
  }) {
    return {
      '@type': 'WebPage',
      'name': name,
      'url': url,
      if (description != null) 'description': description,
      if (datePublished != null) 'datePublished': datePublished.toIso8601String(),
      if (dateModified != null) 'dateModified': dateModified.toIso8601String(),
      if (image != null) 'image': image,
    };
  }

  /// Create Product structured data
  static Map<String, dynamic> product({
    required String name,
    String? description,
    String? image,
    String? brand,
  }) {
    return {
      '@type': 'Product',
      'name': name,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (brand != null) 'brand': {'@type': 'Brand', 'name': brand},
    };
  }

  /// Create FAQ structured data
  static Map<String, dynamic> faq({
    required List<Map<String, String>> questions,
  }) {
    final List<Map<String, dynamic>> faqItems = questions.map((q) => {
      '@type': 'Question',
      'name': q['question'],
      'acceptedAnswer': {
        '@type': 'Answer',
        'text': q['answer'],
      },
    }).toList();

    return {
      '@type': 'FAQPage',
      'mainEntity': faqItems,
    };
  }
}