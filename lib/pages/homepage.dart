import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools;
import 'package:tflite_v2/tflite_v2.dart';

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
    try {
      final matches = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      if (matches == null) {
        devtools.log("recognitions is Null");
        return;
      }
      devtools.log(matches.toString());

      setState(() {
        isModelBusy = false;
        confidence =
            (matches[0]['confidence'] * 100 as double).toStringAsFixed(2);
        label = matches[0]['label'].toString();
      });
    } catch (e) {
      devtools.log("error: $e");
      isModelBusy = false;
    }
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  @override
  void initState() {
    loadModel();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
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
              child: Text(
                "Prediction : $label",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
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
