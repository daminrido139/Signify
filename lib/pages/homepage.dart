import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as im;
import 'package:flutter/material.dart';
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
  int frame = 0;

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
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    await cameraController!.initialize();
    cameraController!.startImageStream((cameraImage) {
      if (isModelBusy) return;
      processImage(cameraImage);
    });
    await Future.delayed(Durations.extralong2);
    switchingCamera = false;

    setState(() {});
  }

  Uint8List _convertYPlaneToImage(CameraImage image) {
    final yPlane = image.planes[0]; // Y plane (luminance)
    final width = image.width;
    final height = image.height;

    // Create an Image from Y plane (grayscale)
    final im.Image grayscaleImage = im.Image(width: height, height: width);

    // Fill in pixel data using Y plane bytes
    for (int y = 0; y < width; y++) {
      for (int x = 0; x < height; x++) {
        final luminance = yPlane.bytes[x * yPlane.bytesPerRow + y];
        // Set the pixel color to the grayscale value
        grayscaleImage.setPixel(height - x - 1, width - y - 1,
            im.ColorInt32.rgb(luminance, luminance, luminance));
      }
    }

    // Convert image to PNG format
    final pngBytes = Uint8List.fromList(im.encodePng(grayscaleImage));
    // Update the image
    return pngBytes;
  }

  void processImage(CameraImage cameraImage) async {
    /////// frame logic ////////
    /// runs once in 30 calls
    if (frame == 10) {
      frame = 0;
    } else {
      frame += 1;
      return;
    }
    /////////////////////////////
    isModelBusy = true;

    label = await NativeRepo.processImage(
      _convertYPlaneToImage(cameraImage),
    );

    setState(() {});
    isModelBusy = false;
  }

  @override
  void initState() {
    initCamera();
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue.shade300,
        onPressed: () {},
        child: const Icon(Icons.audiotrack),
      ),
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
                SizedOverflowBox(
                  size: Size(screenWidth, screenHeight * 0.6),
                  child: Transform.flip(
                    flipX: (cameraController!.description.lensDirection ==
                            CameraLensDirection.front)
                        ? true
                        : false,
                    child: CameraPreview(cameraController!),
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
