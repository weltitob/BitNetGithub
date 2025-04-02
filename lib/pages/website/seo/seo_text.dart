import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'package:flutter/foundation.dart';

class SeoText extends StatelessWidget {
  final String? data;
  final TextTagStyle? tagStyle;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final bool richText;
  final Map<String, String>? structuredData;
  final String? id;
  final String? ariaLabel;
  final String? role;

  const SeoText(
    this.data, {
    Key? key,
    this.tagStyle,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.richText = false,
    this.structuredData,
    this.id,
    this.ariaLabel,
    this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only use SEO wrapper for web environment to avoid unnecessary overhead on mobile
    final String text = data ?? "";
    final bool isBigText = tagStyle == TextTagStyle.h1 || tagStyle == TextTagStyle.h2 || tagStyle == TextTagStyle.h3;
    
    // Base widget that will be enhanced with SEO if on web
    final Widget textWidget = Text(
      text,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel ?? ariaLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
    
    // If not on web, return the basic widget to avoid overhead
    if (!kIsWeb) {
      return textWidget;
    }
    
    // For performance optimization, use Seo.text
    return Seo.text(
      style: tagStyle ?? TextTagStyle.p,
      text: text,
      child: textWidget,
    );
  }
  
  /// Creates an SEO heading (h1) with appropriate semantic markup
  static Widget h1(String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Map<String, String>? structuredData,
    String? id,
    String? ariaLabel,
  }) {
    return SeoText(
      text,
      tagStyle: TextTagStyle.h1,
      style: style,
      textAlign: textAlign,
      structuredData: structuredData,
      id: id,
      ariaLabel: ariaLabel,
    );
  }
  
  /// Creates an SEO heading (h2) with appropriate semantic markup
  static Widget h2(String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Map<String, String>? structuredData,
    String? id,
    String? ariaLabel,
  }) {
    return SeoText(
      text,
      tagStyle: TextTagStyle.h2,
      style: style,
      textAlign: textAlign,
      structuredData: structuredData,
      id: id,
      ariaLabel: ariaLabel,
    );
  }
  
  /// Creates an SEO heading (h3) with appropriate semantic markup
  static Widget h3(String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Map<String, String>? structuredData,
    String? id,
    String? ariaLabel,
  }) {
    return SeoText(
      text,
      tagStyle: TextTagStyle.h3,
      style: style,
      textAlign: textAlign,
      structuredData: structuredData,
      id: id,
      ariaLabel: ariaLabel,
    );
  }
  
  /// Creates an SEO paragraph with appropriate semantic markup
  static Widget paragraph(String text, {
    TextStyle? style,
    TextAlign? textAlign,
    Map<String, String>? structuredData,
    String? id,
    String? ariaLabel,
  }) {
    return SeoText(
      text,
      tagStyle: TextTagStyle.p,
      style: style,
      textAlign: textAlign,
      structuredData: structuredData,
      id: id,
      ariaLabel: ariaLabel,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SeoText &&
      other.data == data &&
      other.style == style &&
      other.tagStyle == tagStyle &&
      other.textAlign == textAlign &&
      other.id == id &&
      other.ariaLabel == ariaLabel &&
      other.role == role;
  }

  @override
  int get hashCode => 
    data.hashCode ^ 
    tagStyle.hashCode ^ 
    style.hashCode ^ 
    textAlign.hashCode ^
    (id?.hashCode ?? 0) ^
    (ariaLabel?.hashCode ?? 0) ^
    (role?.hashCode ?? 0);
}
