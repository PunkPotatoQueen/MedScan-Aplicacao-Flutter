import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:opencv_4/opencv_4.dart';
import '../services/AudioManager/AudioGenerator.dart';

// ignore: must_be_immutable
class ImagePreview extends StatefulWidget {
  ImagePreview(this.imagemAtual, {super.key});
  XFile imagemAtual;

  @override
  State<ImagePreview> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImagePreview> {

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.imagemAtual.path);
    // print(extractText);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text('MedScan')),
          body: Center(
            child: Image.file(picture),
          ),
          // bottomSheet: Text(extractText),
        ),

      ],
    );
  }
}


  // String extractText = '';// inicializando

  // @override
  // void initState() {
  //   super.initState();
  //   extractor();
  // }

  // Future<void> extractor() async {
  //   try {
  //     final inputImage = InputImage.fromFilePath(widget.imagemAtual.path);
      
  //     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  //     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

  //     String text = recognizedText.text;
  //     for (TextBlock block in recognizedText.blocks) {
  //       final Rect rect = block.boundingBox;
  //       final List<Point<int>> cornerPoints = block.cornerPoints;
  //       final String text = block.text;
  //       final List<String> languages = block.recognizedLanguages;
        
  //       for (TextLine line in block.lines) {
  //         // Same getters as TextBlock
  //         for (TextElement element in line.elements) {
  //           // Same getters as TextBlock
  //         }
  //       }
  //     }
      
  //     setState(() {
  //       extractText = text;
  //     });
  //   } catch (e) {
  //     debugPrintStack();
  //   }
  // }
// String text = await FlutterTesseractOcr.extractText(file,
//           language: 'por',
//           args: {
//             "psm": "11",
//             "preserve_interword_spaces": "1",
//           });

//       if (text == '') {
//         text = 'Não encontramos texto nessa imagem';
//       }