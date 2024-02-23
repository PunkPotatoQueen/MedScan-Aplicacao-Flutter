import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto3/models/medicamento_model.dart';
import '../services/ocr_service.dart';



class ImagePage extends StatefulWidget {
  ImagePage(this.file, {super.key});
  XFile file;

  @override
  State<ImagePage> createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {
  Medicamento? _medicamento;

  _getOcrText() async {
    final ocrService = OCRService();
    Medicamento medicamento = await ocrService.tesseractExtract(widget.file);

    setState(() {
      _medicamento = medicamento;
    });
  }

  @override
  void initState() {
    super.initState();
    _getOcrText();
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    return Scaffold(
      appBar: AppBar(title: const Text(
          'MedScan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Image.file(picture),
          ],
        ) 
      ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          child: Text(_medicamento?.text ?? 'Carregando informação...'),
        ),
      ),
    );
  }
}
