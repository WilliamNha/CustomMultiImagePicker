import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('custom_multi_image_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//  test('getPlatformVersion', () async {
//    var platformVersion;
//    expect(await CustomMultiImagePicker.platformVersion, '42');
//  });
}
