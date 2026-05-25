import 'package:flutter/material.dart';

/// Reusable text styles for the Mini Games app.
///
/// All sizes are intentionally large for readability by children ages 4-8.
/// Use these via `Theme.of(context).extension<MiniGamesTextStyles>()` or
/// reference them directly.
abstract final class TextStyles {
  TextStyles._();

  /// Large heading style — 28 px, bold.
  ///
  /// Suitable for screen titles and primary headings.
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: 0.25,
  );

  /// Subheading style — 22 px, semi-bold.
  ///
  /// Suitable for section headers and card titles.
  static const TextStyle subheading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  /// Body text style — 18 px, normal weight.
  ///
  /// Suitable for paragraphs, descriptions, and general content.
  static const TextStyle body = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  /// Caption / label style — 14 px, normal weight.
  ///
  /// Suitable for hints, timestamps, and secondary information.
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );
}
