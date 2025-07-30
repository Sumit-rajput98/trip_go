// // VoiceSearchPage.dart
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// class VoiceSearchPage extends StatefulWidget {
//   const VoiceSearchPage({Key? key}) : super(key: key);
//
//   @override
//   _VoiceSearchPageState createState() => _VoiceSearchPageState();
//
//
// class _VoiceSearchPageState extends State<VoiceSearchPage> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Say something...';
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   void _startListening() async {
//     bool available = await _speech.initialize(
//       onStatus: (val) => print('Status: $val'),
//       onError: (val) => print('Error: $val'),
//     );
//     if (available) {
//       setState(() => _isListening = true);
//       _speech.listen(
//         onResult: (val) => setState(() {
//           _text = val.recognizedWords;
//         }),
//       );
//     }
//   }
//
//   void _stopListening() {
//     setState(() => _isListening = false);
//     _speech.stop();
//   }
//
//   @override
//   void dispose() {
//     _speech.stop();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Voice Search")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _text,
//               style: const TextStyle(fontSize: 20, color: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             FloatingActionButton(
//               onPressed: _isListening ? _stopListening : _startListening,
//               child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
