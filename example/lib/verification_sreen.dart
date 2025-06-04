import 'package:bvn_selfie_pk/bvn_selfie_pk.dart';
import 'package:bvn_selfie_pk/bvn_selfie_pk_view.dart';
import 'package:bvn_selfie_pk_example/show_result.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late BvnServiceProvider provider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BvnSelfieView(
      allowTakePhoto: false,
      onImageCapture: (image) {
        print(image);
        provider.destroyer();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShowResult(path: image)));
      },
      onError: (String errorLog) {
        print(errorLog);
      },
      onInit: (BvnServiceProvider provider) {
        this.provider = provider;
      },
    ));
  }
}
