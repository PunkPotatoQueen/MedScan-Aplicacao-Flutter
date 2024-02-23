import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:camera/camera.dart';
import 'package:projeto3/models/medicamento_model.dart';


class OCRService {

  Future<Medicamento> tesseractExtract(XFile file) async {

    String extractText = await FlutterTesseractOcr.extractText(file.path,
        language: 'por',
        args: {
          "psm": "11",
          "preserve_interword_spaces": "1",
        }
        );

    if (extractText == '') {
      extractText = 'Não encontramos texto nessa imagem';
    }

    print('texto extraído ' + extractText);

    Medicamento medicamento = Medicamento(extractText);

    return medicamento;
  }
}
