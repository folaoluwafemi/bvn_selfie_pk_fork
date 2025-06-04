// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:bvn_selfie_pk/bvn_selfie_pk_method_channel.dart';

// void main() {
//   MethodChannelBvnSelfie platform = MethodChannelBvnSelfie();
//   const MethodChannel channel = MethodChannel('bvn_selfie_pk');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }
