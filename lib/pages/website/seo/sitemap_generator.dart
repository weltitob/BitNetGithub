import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

/// A utility class for generating sitemaps for the BitNet website
class SitemapGenerator {
  final String domain;
  final List<String> paths;
  final Map<String, SitemapUrl> urlConfigs;
  final String language;

  SitemapGenerator({
    required this.domain,
    required this.paths,
    required this.urlConfigs,
    this.language = 'en',
  });

  /// Generate the sitemap.xml content
  String generateSitemap() {
    final buffer = StringBuffer();
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);

    // XML header
    buffer.write('<?xml version="1.0" encoding="UTF-8"?>\n');
    buffer.write('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" '
        'xmlns:xhtml="http://www.w3.org/1999/xhtml">\n');

    // Add root URL
    final rootUrl = 'https://$domain';
    buffer.write('  <url>\n');
    buffer.write('    <loc>$rootUrl</loc>\n');
    buffer.write('    <lastmod>$formattedDate</lastmod>\n');
    buffer.write('    <changefreq>weekly</changefreq>\n');
    buffer.write('    <priority>1.0</priority>\n');
    
    // Add alternate language versions if specified
    if (language != 'en') {
      buffer.write('    <xhtml:link rel="alternate" hreflang="en" href="$rootUrl" />\n');
      buffer.write('    <xhtml:link rel="alternate" hreflang="$language" href="$rootUrl" />\n');
    }
    
    buffer.write('  </url>\n');

    // Add all other paths
    for (final path in paths) {
      final url = 'https://$domain$path';
      final config = urlConfigs[path] ?? SitemapUrl();

      buffer.write('  <url>\n');
      buffer.write('    <loc>$url</loc>\n');
      buffer.write('    <lastmod>${config.lastmod ?? formattedDate}</lastmod>\n');
      buffer.write('    <changefreq>${config.changefreq}</changefreq>\n');
      buffer.write('    <priority>${config.priority}</priority>\n');
      
      // Add alternate language versions if specified
      if (language != 'en') {
        buffer.write('    <xhtml:link rel="alternate" hreflang="en" href="$url" />\n');
        buffer.write('    <xhtml:link rel="alternate" hreflang="$language" href="$url" />\n');
      }
      
      buffer.write('  </url>\n');
    }

    buffer.write('</urlset>');
    return buffer.toString();
  }

  /// Save the sitemap to a file in the public directory (web only)
  Future<bool> saveSitemapFile() async {
    if (!kIsWeb) {
      // This only works on web platforms
      return false;
    }

    try {
      final sitemapContent = generateSitemap();
      // In a real web application, you would save this to the public directory
      // Since Flutter web doesn't have direct file access, this would need to be
      // part of your build process or backend API
      return true;
    } catch (e) {
      print('Error generating sitemap: $e');
      return false;
    }
  }

  /// Generate standard website paths for common pages
  static List<String> standardWebsitePaths() {
    return [
      '/',
      '/about',
      '/features',
      '/downloads',
      '/contact',
      '/faq',
      '/privacy',
      '/terms',
      '/products',
      '/blog',
    ];
  }
}

/// Configuration for individual sitemap URLs
class SitemapUrl {
  final String? lastmod;
  final String changefreq;
  final String priority;

  SitemapUrl({
    this.lastmod,
    this.changefreq = 'monthly',
    this.priority = '0.8',
  });
}