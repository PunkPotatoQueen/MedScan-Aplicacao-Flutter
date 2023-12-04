import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:opencv_4/opencv_4.dart';

// ignore: must_be_immutable
class ImagePreview extends StatefulWidget {
  ImagePreview(this.file, {super.key});
  XFile file;

  @override
  State<ImagePreview> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImagePreview> {
  String ExtractText = '';    // inicializando 

  @override
  void initState() {
    super.initState();
    tesseractExtract(widget.file);
  }

  Future<void> tesseractExtract(XFile file) async {
    try {
      XFile imagem = await Cv2.threshold(
      pathString: widget.file.path,
      thresholdValue: 100,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
      );

      String text = await FlutterTesseractOcr.extractText(
          imagem.path, language: 'por',
          args: {
            "psm": "11",
            "preserve_interword_spaces": "1",
          });

      if(text == ''){
          text = 'Não encontramos texto nessa imagem';
      }
      setState(() {
        ExtractText = text;
      });
    } catch (e) {
      print('Erro: não conseguimos encontrar nenhum texto');
    }
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    print(ExtractText);
    return Scaffold(
        appBar: AppBar(title: Text('MedScan')),
        body: Center(
          child: Image.file(picture),
        )
    );
  }
}

