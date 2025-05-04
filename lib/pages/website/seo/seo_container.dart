// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:seo/seo.dart';
// import 'package:bitnet/pages/website/seo/structured_data.dart';

// /// A container widget that adds SEO improvements to any child widget
// /// This includes semantic HTML, accessibility attributes, and structured data
// class SeoContainer extends StatelessWidget {
//   final Widget child;
//   final String title;
//   final String description;
//   final String? canonicalUrl;
//   final String? image;
//   final Map<String, dynamic>? structuredData;
//   final Map<String, String>? htmlAttributes;
//   final String? mainSchemaType;
//   final List<String>? keywords;
//   final String? id;
//   final String? role;
//   final String? ariaLabel;

//   const SeoContainer({
//     Key? key,
//     required this.child,
//     required this.title,
//     required this.description,
//     this.canonicalUrl,
//     this.image,
//     this.structuredData,
//     this.htmlAttributes,
//     this.mainSchemaType,
//     this.keywords,
//     this.id,
//     this.role,
//     this.ariaLabel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // If not on web, just return the child to avoid overhead
//     if (!kIsWeb) {
//       return child;
//     }

//     // Create the base container with Seo.head metadata
//     Widget seoWidget = Seo.head(
//       tags: [
//         // Title meta tag
//         MetaTag(name: 'title', content: title),
        
//         // Description meta tag
//         MetaTag(name: 'description', content: description),
        
//         // Keywords meta tag if provided
//         if (keywords != null && keywords!.isNotEmpty)
//           MetaTag(name: 'keywords', content: keywords!.join(', ')),
        
//         // Canonical URL meta tag if provided  
//         if (canonicalUrl != null)
//           LinkTag(rel: 'canonical', href: canonicalUrl!),
//       ],
//       child: child,
//     );

//     // Add structured data if provided
//     if (structuredData != null && structuredData!.isNotEmpty) {
//       seoWidget = StructuredData(
//         jsonLdData: structuredData!,
//         child: seoWidget,
//       );
//     } else if (mainSchemaType != null) {
//       // If no structured data is provided but a schema type is, create basic structured data
//       final defaultStructuredData = {
//         '@type': mainSchemaType,
//         'name': title,
//         'description': description,
//         if (image != null) 'image': image,
//         if (canonicalUrl != null) 'url': canonicalUrl,
//       };
      
//       seoWidget = StructuredData(
//         jsonLdData: defaultStructuredData,
//         child: seoWidget,
//       );
//     }

//     return seoWidget;
//   }
// }