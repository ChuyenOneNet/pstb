import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  SpeechToText speechToText = SpeechToText();
  final nurseController = Modular.get<NurseSearchingStore>();

  var text = "Hãy giữ nút và bắt đầu nói!";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 24,
                color: isListening ? Colors.black87 : Colors.black26,
                fontWeight: FontWeight.w600),
          ),
        ),
        AvatarGlow(
          animate: isListening,
          duration: const Duration(milliseconds: 2000),
          glowColor: Colors.red,
          repeat: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                      if (nurseController.isProgression) {
                        nurseController.progression = "";
                        nurseController.setDevelopments(result.recognizedWords);
                      } else {
                        nurseController.attentionInformation = "";
                        nurseController.setHealthCare(result.recognizedWords);
                      }
                    });
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
              Future.delayed(const Duration(seconds: 1), () {
                Modular.to.pop();
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 35,
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
