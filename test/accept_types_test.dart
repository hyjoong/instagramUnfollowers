import 'package:flutter_test/flutter_test.dart';
import 'package:trackfollows/webview_service.dart';

void main() {
  test('maps web accept attribute to picker extensions', () {
    expect(WebViewService.allowedExtensionsFromAccept(['.zip,.json,.html']),
        unorderedEquals(['zip', 'json', 'html']));
    expect(WebViewService.allowedExtensionsFromAccept(['.zip', 'application/json']),
        unorderedEquals(['zip', 'json']));
    expect(WebViewService.allowedExtensionsFromAccept(['application/x-zip-compressed']), ['zip']);
  });

  test('falls back to all files for empty or unknown accept values', () {
    expect(WebViewService.allowedExtensionsFromAccept([]), isEmpty);
    expect(WebViewService.allowedExtensionsFromAccept(['']), isEmpty);
    expect(WebViewService.allowedExtensionsFromAccept(['image/*']), isEmpty);
  });
}
