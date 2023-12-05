import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
// import 'package:opencv_4/opencv_4.dart';
import '../AudioManager/AudioGenerator.dart';

// ignore: must_be_immutable
class ImagePreview extends StatefulWidget {
  ImagePreview(this.file, {super.key});
  XFile file;

  @override
  State<ImagePreview> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImagePreview> {
  String extractText = ''; // inicializando

  @override
  void initState() {
    super.initState();
    tesseractExtract(widget.file);
  }

  Future<void> tesseractExtract(XFile file) async {
    try {

      String text = await FlutterTesseractOcr.extractText(widget.file.path,
          language: 'por',
          args: {
            "psm": "11",
            "preserve_interword_spaces": "1",
          });

      if (text == '') {
        text = 'Não encontramos texto nessa imagem';
      }
      setState(() {
        extractText = text;
      });
      AudioGenerator.generate(extractText);
    } catch (e) {
      debugPrintStack();
    }
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('MedScan')),
          body: Center(
            child: Image.file(picture),
          ),
          bottomSheet: Text(extractText),
        ),

      ],
    );
  }
}

// XFile imagem = await Cv2.threshold(
      // pathString: widget.file.path,
      // thresholdValue: 100,
      // maxThresholdValue: 200,
      // thresholdType: Cv2.THRESH_BINARY,
      // );