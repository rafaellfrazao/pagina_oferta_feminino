import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Helper class for Meta Pixel tracking
class MetaPixelHelper {
  /// Track a standard Meta Pixel event
  static void trackEvent(String eventName, [Map<String, dynamic>? parameters]) {
    try {
      if (!kIsWeb) return;
      
      final fbq = js.context['fbq'];
      if (fbq == null) {
        print('Meta Pixel fbq not available');
        return;
      }

      if (parameters != null && parameters.isNotEmpty) {
        final jsParams = js.JsObject.jsify(parameters);
        fbq.callMethod('track', [eventName, jsParams]);
      } else {
        fbq.callMethod('track', [eventName]);
      }
    } catch (e) {
      print('Error tracking Meta Pixel event: $e');
    }
  }

  /// Track InitiateCheckout event
  static void trackInitiateCheckout() {
    trackEvent('InitiateCheckout', {
      'content_category': 'Beauty',
      'content_name': 'Brazilian Beauty Code',
      'currency': 'USD',
      'value': 12.00,
    });
  }

  /// Track Purchase event
  static void trackPurchase() {
    trackEvent('Purchase', {
      'content_category': 'Beauty',
      'content_name': 'Brazilian Beauty Code',
      'currency': 'USD',
      'value': 12.00,
    });
  }

  /// Track Lead event
  static void trackLead() {
    trackEvent('Lead', {
      'content_category': 'Beauty',
      'content_name': 'Brazilian Beauty Code',
    });
  }
}
