import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class SeoText extends Text {
  final TextTagStyle? tagStyle;
  const SeoText(super.data,
      {super.key,
      this.tagStyle,
      super.style,
      super.strutStyle,
      super.textAlign,
      super.textDirection,
      super.locale,
      super.softWrap,
      super.overflow,
      super.textScaleFactor,
      super.maxLines,
      super.semanticsLabel,
      super.textWidthBasis,
      super.textHeightBehavior,
      super.selectionColor});

  @override
  Widget build(BuildContext context) {
    return Seo.text(
      style: tagStyle != null ? tagStyle! : TextTagStyle.p,
      text: data != null ? data! : "",
      child: Text(
        data != null ? data! : "",
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
}
