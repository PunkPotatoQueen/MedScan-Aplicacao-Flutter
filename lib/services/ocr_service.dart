// import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
// import 'package:camera/camera.dart';
import 'package:projeto3/models/medicamento_model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class OCRService {
  String _textoDaImagem = '';

  Future<Medicamento> extractText(String path) async {
    final inputImage = await InputImage.fromFilePath(
        path); // inicialização da imagem a ser trabalhada

    final detectorTexto = GoogleMlKit.vision.textRecognizer();

    final RecognizedText textoReconhecido =
        await detectorTexto.processImage(inputImage);

    for (TextBlock bloco in textoReconhecido.blocks) {
      for (TextLine linhaTexto in bloco.lines) {
        for (TextElement elemento_Texto in linhaTexto.elements) {
          _textoDaImagem = _textoDaImagem + " " + elemento_Texto.text;
        }
      }

      _textoDaImagem += '\n'; //Pular linha entre palavras
    }

    Medicamento medicamento = Medicamento(_textoDaImagem);

    return medicamento;
  }
}
//     Medicamento medicamento = Medicamento(extractText);

    
//   }
// }
