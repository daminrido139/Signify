import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:signify/services/native_repo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String label = "Listening for a Indian Sign...";
  String confidence = "";
  CameraController? cameraController;
  bool isModelBusy = false;
  List<CameraDescription>? _availableCameras;
  bool switchingCamera = false;
  double screenWidth = 0;
  double screenHeight = 0;
  late final ScreenshotController _screenshotController;

  void initCamera() async {
    _availableCameras = await availableCameras();
    setCameraDirection(CameraLensDirection.front);
  }

  void toggleCameraDirection() {
    if (cameraController == null) return;
    setState(() {
      switchingCamera = true;
    });
    if (cameraController!.description.lensDirection ==
        CameraLensDirection.front) {
      setCameraDirection(CameraLensDirection.back);
    } else {
      setCameraDirection(CameraLensDirection.front);
    }
  }

  Future<void> setCameraDirection(CameraLensDirection direction) async {
    final CameraDescription cameraDescription =
        _availableCameras!.firstWhere((i) => i.lensDirection == direction);
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    await cameraController!.initialize();
    cameraController!.startImageStream((cameraImage) {
      if (isModelBusy) return;
      processImage(cameraImage);
    });
    await Future.delayed(Durations.extralong2);
    switchingCamera = false;

    setState(() {});
  }

  void processImage(CameraImage cameraImage) async {
    isModelBusy = true;
    label = await NativeRepo.processImage(
      cameraImage.planes.map((plane) => plane.bytes).toList(),
      cameraImage.height,
      cameraImage.width,
    );
    setState(() {});
    isModelBusy = false;
  }

  @override
  void initState() {
    initCamera();
    _screenshotController = ScreenshotController();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        children: [
          _cameraPreview(),
          Expanded(
            child: Center(
              child: SelectableText(
                "Prediction : $label",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   backgroundColor: Colors.blue.shade300,
      //   onPressed: () {},
      //   child: const Icon(Icons.audiotrack),
      // ),
    );
  }

  Widget _cameraPreview() {
    return (cameraController == null || switchingCamera)
        ? Container(
            height: screenHeight * 0.6,
            alignment: Alignment.center,
            color: Colors.black,
            child: CircularProgressIndicator(
              color: Colors.blue.shade100,
            ),
          )
        : ClipRRect(
            child: Stack(
              children: [
                Screenshot(
                  controller: _screenshotController,
                  child: SizedOverflowBox(
                    size: Size(screenWidth, screenHeight * 0.6),
                    child: Transform.flip(
                      flipX: (cameraController!.description.lensDirection ==
                              CameraLensDirection.front)
                          ? true
                          : false,
                      child: CameraPreview(cameraController!),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: screenWidth,
                      color: Colors.black26,
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: IconButton(
                    color: Colors.grey.shade100,
                    onPressed: toggleCameraDirection,
                    icon: const Icon(
                      Icons.flip_camera_ios,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
