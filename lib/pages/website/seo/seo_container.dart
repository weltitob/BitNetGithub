import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'package:bitnet/pages/website/seo/structured_data.dart';

/// A container widget that adds SEO improvements to any child widget
/// This includes semantic HTML, accessibility attributes, and structured data
class SeoContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final String description;
  final String? canonicalUrl;
  final String? image;
  final Map<String, dynamic>? structuredData;
  final Map<String, String>? htmlAttributes;
  final String? mainSchemaType;
  final List<String>? keywords;
  final String? id;
  final String? role;
  final String? ariaLabel;

  const SeoContainer({
    Key? key,
    required this.child,
    required this.title,
    required this.description,
    this.canonicalUrl,
    this.image,
    this.structuredData,
    this.htmlAttributes,
    this.mainSchemaType,
    this.keywords,
    this.id,
    this.role,
    this.ariaLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If not on web, just return the child to avoid overhead
    if (!kIsWeb) {
      return child;
    }

    // Create HTML attributes map
    final Map<String, String> attributes = {};
    
    // Add accessibility attributes
    if (id != null) attributes['id'] = id!;
    if (role != null) attributes['role'] = role!;
    if (ariaLabel != null) attributes['aria-label'] = ariaLabel!;
    
    // Add custom HTML attributes if provided
    if (htmlAttributes != null) {
      attributes.addAll(htmlAttributes!);
    }

    // Create the base container with Seo.head metadata
    Widget seoWidget = Seo.head(
      tags: [
        // Title meta tag
        MetaTag(name: 'title', content: title),
        
        // Description meta tag
        MetaTag(name: 'description', content: description),
        
        // Keywords meta tag if provided
        if (keywords != null && keywords!.isNotEmpty)
          MetaTag(name: 'keywords', content: keywords!.join(', ')),
        
        // Canonical URL meta tag if provided  
        if (canonicalUrl != null)
          LinkTag(rel: 'canonical', href: canonicalUrl!),
        
        // Open Graph tags for social sharing  
        MetaTag(property: 'og:title', content: title),
        MetaTag(property: 'og:description', content: description),
        if (image != null) 
          MetaTag(property: 'og:image', content: image!),
        if (canonicalUrl != null)
          MetaTag(property: 'og:url', content: canonicalUrl!),
        MetaTag(property: 'og:type', content: 'website'),
        
        // Twitter Card tags
        MetaTag(name: 'twitter:card', content: 'summary_large_image'),
        MetaTag(name: 'twitter:title', content: title),
        MetaTag(name: 'twitter:description', content: description),
        if (image != null)
          MetaTag(name: 'twitter:image', content: image!),
      ],
      child: Seo.data(
        // Use semantic HTML for the main content
        data: '<main${_attributesToString(attributes)}>',
        child: Seo.data(
          data: '</main>',
          child: child,
        ),
      ),
    );

    // Add structured data if provided
    if (structuredData != null && structuredData!.isNotEmpty) {
      seoWidget = StructuredData(
        jsonLdData: structuredData!,
        child: seoWidget,
      );
    } else if (mainSchemaType != null) {
      // If no structured data is provided but a schema type is, create basic structured data
      final defaultStructuredData = {
        '@type': mainSchemaType,
        'name': title,
        'description': description,
        if (image != null) 'image': image,
        if (canonicalUrl != null) 'url': canonicalUrl,
      };
      
      seoWidget = StructuredData(
        jsonLdData: defaultStructuredData,
        child: seoWidget,
      );
    }

    return seoWidget;
  }

  /// Converts a map of attributes to an HTML attribute string
  String _attributesToString(Map<String, String> attributes) {
    if (attributes.isEmpty) return '';
    
    return attributes.entries
        .map((entry) => ' ${entry.key}="${entry.value}"')
        .join();
  }
}