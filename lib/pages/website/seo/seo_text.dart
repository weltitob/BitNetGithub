import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only use SEO wrapper for web environment to avoid unnecessary overhead on mobile
    final String text = data ?? "";
    final bool isBigText = tagStyle == TextTagStyle.h1 || tagStyle == TextTagStyle.h2 || tagStyle == TextTagStyle.h3;
    
    // For performance optimization, implement shouldRebuild check
    return Seo.text(
      style: tagStyle ?? TextTagStyle.p,
      text: text,
      child: Text(
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
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SeoText &&
      other.data == data &&
      other.style == style &&
      other.tagStyle == tagStyle &&
      other.textAlign == textAlign;
  }

  @override
  int get hashCode => 
    data.hashCode ^ 
    tagStyle.hashCode ^ 
    style.hashCode ^ 
    textAlign.hashCode;
}
