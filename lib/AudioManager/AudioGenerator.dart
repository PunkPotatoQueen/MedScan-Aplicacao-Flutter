import 'dart:io';
import 'AudioStorage.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../apiKey.dart';
//import 'package:audioplayers/audioplayers.dart';

class AudioGenerator {
  static Future<void> generate(String text) async{
    var payload = {
      "audioConfig": {
        "audioEncoding": "MP3",
        "effectsProfileId": [
          "handset-class-device"
        ],
        "pitch": 0,
        "speakingRate": 1.0
      },
      "input": {
        "text": text
      },
      "voice": {
        "languageCode": "pt-BR",
        "name": "pt-BR-Wavenet-B"
      }
    };

    var url = Uri.parse('https://texttospeech.googleapis.com/v1beta1/text:synthesize?key=${key}');
    HttpClient client = HttpClient();
    HttpClientRequest request = await client.postUrl(url);
    request.write(json.encode(payload));

    HttpClientResponse response = await request.close();

    var output = await response.transform(utf8.decoder).join();
    var outputJson = jsonDecode(output);

    Uint8List decodedBytes = base64Decode(outputJson['audioContent']);
    AudioStorage.writeCounter(decodedBytes, '1.mp3');
  }
  //static Future<void> play() async{
    //develop
    //There'll be params in the future
    //final player = AudioPlayer();
    //await player.play(DeviceFileSource('/storage/emulated/0/Download/tmp/1.mp3'));
  //}
}