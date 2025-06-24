import 'package:bvn_selfie_pk/bvn_selfie_pk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BvnSelfieView extends StatefulWidget {
  final Function(String) onImageCapture;
  final Function(String) onError;
  final Function(BvnServiceProvider) onInit;
  final bool allowTakePhoto;

  final Color? textColor;

  const BvnSelfieView(
      {super.key,
      required this.onImageCapture,
      required this.onError,
      this.textColor,
      required this.allowTakePhoto,
      required this.onInit});

  @override
  State<BvnSelfieView> createState() => _BvnSelfieViewState();
}

class _BvnSelfieViewState extends State<BvnSelfieView>
    with SingleTickerProviderStateMixin {
  bool enabled = false;
  late AnimationController _animationController;
  String? actionText;
  double count = 0;
  late BvnServiceProvider instance;

  Color surfaceColor = Colors.red;
  int? textureId;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        enabled = true;
        setState(() {});
      }
    });
    instance = BvnServiceProvider(
        controller: BvnServiceProviderController(
      onProgressChange: (progress) {
        count = progress * 0.25;
      },
      onTextureCreated: (textureID) {
        textureId = textureID;
        setState(() {});
      },
      gesturetEvent: (DetectionType type) {
        if (type == DetectionType.NoFaceDetected) {
          surfaceColor = Colors.red;
          setState(() {});
          return;
        }
        if (type == DetectionType.FaceDetected) {
          surfaceColor = Colors.transparent;
          setState(() {});
          return;
        }
      },
      actionRecongnition: (RecongnitionType recongnitionType) {
        if (recongnitionType == RecongnitionType.SMILE_AND_BLINK) {
          actionText = "SMILE AND BLINK";
          setState(() {});
          return;
        }
        if (recongnitionType == RecongnitionType.FROWN_ONLY) {
          actionText = "FROWN FACE";
          setState(() {});
          return;
        }
        if (recongnitionType == RecongnitionType.CLOSE_AND_OPEN_SLOWLY) {
          actionText = "CLOSE AND OPEN EYE SLOWLY";
          setState(() {});
          return;
        }
        if (recongnitionType == RecongnitionType.HEAD_ROTATE) {
          actionText = "ROTATE HEAD SLOWLY";
          setState(() {});
          return;
        }
        if (recongnitionType == RecongnitionType.SMILE_AND_OPEN_ONLY) {
          if (mounted) {
            actionText = "☺️☺️ SMILE ☺️☺️";
          }
          setState(() {});
        }
        if (recongnitionType == RecongnitionType.NEUTRAL_FACE) {
          if (mounted) {
            actionText = "KEEP A NEUTRAL EXPRESSION";
          }
          setState(() {});
          return;
        }
      },
      onImageCapture: widget.onImageCapture,
      onError: widget.onError,
      onInit: widget.onInit,
    ));

    instance.startBvnService();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    widget.onInit(instance);
    super.initState();
  }

  String loadAsset(String asset) {
    return "packages/bvn_selfie_pk/asset/$asset";
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    Size size = MediaQuery.of(context).size;
    if (textureId == null && TargetPlatform.android == defaultTargetPlatform) {
      return const SizedBox();
    } else {
      return SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: size.width * 0.76,
              width: size.width * 0.76,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      textureId != null ? (surfaceColor) : Colors.transparent),
            ),
            Container(
              height: size.width * 0.76,
              width: size.width * 0.76,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: textureId != null
                      ? Colors.transparent
                      : Colors.transparent),
              child: CircularProgressIndicator(
                color: surfaceColor != Colors.transparent
                    ? Colors.transparent
                    : const Color(0xff5724A6),
                value: count,
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: SizedBox(
                    height: size.width * 0.74,
                    width: size.width * 0.74,
                    child: AspectRatio(
                        aspectRatio: size.width / (size.width * 1.9),
                        child: defaultTargetPlatform == TargetPlatform.android
                            ? Texture(textureId: textureId!)
                            : UiKitView(
                                viewType: "bvnview_cam",
                                creationParams: creationParams,
                                creationParamsCodec:
                                    const StandardMessageCodec(),
                              )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.2,
              child: Text(
                actionText ?? "PLACE YOUR FACE PROPERLY",
                style: TextStyle(
                    fontSize: 16,
                    color: widget.textColor,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Image.asset(
              loadAsset("frame_cover.png"),
              color: surfaceColor == Colors.transparent
                  ? const Color(0xff5724A6).withOpacity(0.7)
                  : surfaceColor,
              width: size.width * 0.76,
            ),
            if (widget.allowTakePhoto &&
                enabled &&
                TargetPlatform.android == defaultTargetPlatform) ...[
              Positioned(
                  bottom: size.height * 0.14,
                  child: GestureDetector(
                    onTap: () {
                      instance.takePhoto();
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 54,
                          padding: const EdgeInsets.all(3),
                          width: 54,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff5724A6),
                          ),
                          child: Container(
                            height: 54,
                            width: 54,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("You Can Take Shot Now...")
                      ],
                    ),
                  )),
            ]
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
