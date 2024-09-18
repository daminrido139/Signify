import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signify/Student/services/camera_services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String label = "Listening for a Indian Sign...";
  String gujarathi = "ભારતીય નિશાની સાંભળી રહ્યા છીએ...";
  String confidence = "";
  CameraController? cameraController;
  List<CameraDescription>? _availableCameras;
  bool switchingCamera = false;
  double screenWidth = 0;
  double screenHeight = 0;
  String timeTaken = '';
  bool isRecording = false;
  bool flash = true;
  final List<CameraImage> recordFrames = [];
  GoogleTranslator translator = GoogleTranslator();

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

  Future talkToMe(String text) async {
    // Create a tts object
    FlutterTts flutterTts = FlutterTts();

    // Set properties
    flutterTts.setLanguage("en-US");
    flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    flutterTts.setSpeechRate(0.6);
    flutterTts.setPitch(1); // 0.5 - 1.5

    // Speak
    flutterTts.speak(text);
  }

  Future<void> toggleFlashlight() async {
    if (cameraController!.description.lensDirection !=
        CameraLensDirection.front) {
      if (cameraController!.value.isInitialized) {
        if (cameraController!.value.flashMode == FlashMode.off) {
          await cameraController!.setFlashMode(FlashMode.torch);
          setState(() {
            flash = true;
          });
        } else {
          await cameraController!.setFlashMode(FlashMode.off);
          setState(() {
            flash = false;
          });
        }
      }
    }
  }

  Future<void> setCameraDirection(CameraLensDirection direction) async {
    final CameraDescription cameraDescription =
        _availableCameras!.firstWhere((i) => i.lensDirection == direction);
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );
    await cameraController!.initialize();
    cameraController!.startImageStream(processImage);
    await Future.delayed(Durations.extralong2);
    switchingCamera = false;

    setState(() {});
  }

  void processImage(CameraImage cameraImage) {
    if (isRecording) {
      recordFrames.add(cameraImage);
    }
  }

  void trans(String txt) async {
    gujarathi = await translator.translate(txt, to: 'gu').then((v) {
      return v.toString();
    });
    setState(() {});
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
          const SizedBox(
            height: 30,
          ),
          isRecording == true
              ? Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/img/bot.gif")),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "English:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 250, 158, 83)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SelectableText(
                        "Prediction : $label",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Gujarthi:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 250, 158, 83)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SelectableText(
                        "આગાહી : $gujarathi",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
        onPressed: () async {
          await talkToMe(label);
        },
        child: const Icon(
          Icons.multitrack_audio_sharp,
          size: 36,
        ),
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
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      if (isRecording) return;
                      recordFrames.clear();
                      setState(() {
                        isRecording = true;
                      });
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        label = "loading...";
                        trans("loading...");
                        isRecording = false;
                      });
                      label = await compute(CameraServices.predictGesture, [
                        recordFrames,
                        cameraController!.description.lensDirection
                      ]);
                      setState(() {});
                      trans(label);
                      talkToMe(label);
                    },
                    child: (isRecording)
                        ? const _StopRecordIcon(Duration(seconds: 2))
                        : const _StartRecordIcon(),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  child: IconButton(
                    color: Colors.grey.shade100,
                    onPressed: toggleCameraDirection,
                    icon: Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.black26,
                      ),
                      padding: const EdgeInsets.all(13),
                      child: const Icon(
                        Icons.flip_camera_ios,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 50,
                  child: IconButton(
                    color: Colors.grey.shade100,
                    onPressed: toggleFlashlight,
                    icon: Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.black26,
                      ),
                      padding: const EdgeInsets.all(13),
                      child: Icon(
                        flash == false ? Icons.flash_off : Icons.flash_on,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class _StartRecordIcon extends StatelessWidget {
  const _StartRecordIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const ShapeDecoration(
        shape: CircleBorder(
            side: BorderSide(
          width: 5,
          color: Colors.white,
        )),
        color: Colors.red,
      ),
    );
  }
}

class _StopRecordIcon extends StatefulWidget {
  const _StopRecordIcon(this.duration);
  final Duration duration;

  @override
  State<_StopRecordIcon> createState() => __StopRecordIconState();
}

class __StopRecordIconState extends State<_StopRecordIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.white,
          ),
          child: Container(
            height: 20,
            width: 20,
            decoration: ShapeDecoration(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizedBox.square(
                dimension: 55,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.red,
                  value: _controller.value,
                ),
              );
            }),
      ],
    );
  }
}
