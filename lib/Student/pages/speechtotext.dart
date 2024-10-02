import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speechtotext extends StatefulWidget {
  const Speechtotext({super.key});

  @override
  State<Speechtotext> createState() => _SpeechtotextState();
}

class _SpeechtotextState extends State<Speechtotext> {
  String label = "Listening for a Indian Sign...";
  String confidence = "";
  CameraController? cameraController;
  List<CameraDescription>? _availableCameras;
  bool switchingCamera = false;
  double screenWidth = 0;
  double screenHeight = 0;
  String timeTaken = '';
  bool isRecording = false;
  bool flash = true;
  String selectedLang = "English";
  final List<CameraImage> recordFrames = [];
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String finalword = '';

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

  @override
  void initState() {
    initSpeech();
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Face reaction to Text'),
        backgroundColor: const Color.fromARGB(255, 233, 223, 190),
      ),
      backgroundColor:
          isRecording ? Colors.white : const Color.fromARGB(255, 233, 223, 190),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _cameraPreview(),
            const SizedBox(
              height: 15,
            ),
            isRecording == true
                ? Center(
                    child: SizedBox(
                        height: screenHeight * 0.2,
                        child: Image.asset("assets/img/bot.gif")),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 2),
                              height: 35,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFB6B1B1)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              //alignment: Alignment.centerRight,
                              child: DropdownButton(
                                padding: const EdgeInsets.only(
                                    left: 13, top: 6, bottom: 6, right: 8),
                                underline: const SizedBox(),
                                dropdownColor: Colors.white,
                                value: selectedLang,
                                iconSize: 19,
                                borderRadius: BorderRadius.circular(20),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: <String>["English", "Gujarti"]
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  selectedLang = val!;
                                  setState(() {});
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 233, 223, 190)),
                                child: const Icon(Icons.volume_up),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: screenHeight * 0.18,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: screenHeight * 0.1,
                            child: Center(
                              child: Text(
                                finalword,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ],
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
                      // if (isRecording) return;
                      // startListening();
                      setState(() {
                        isRecording = true;
                      });
                      await Future.delayed(const Duration(seconds: 4));
                      finalword = "Welcome to Leviosa";

                      isRecording = false;
                      // stopListening();
                      setState(() {});
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
