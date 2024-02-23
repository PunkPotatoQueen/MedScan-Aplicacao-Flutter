import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'image_page.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<CameraPage> createState() {
    return CameraPageState(cameras);
  }
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;

  final List<CameraDescription> cameras;

  CameraPageState(this.cameras);

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (e is CameraException) {
        print('Error initializing camera: ${e.description}');
      }
    }
  }

  @override
  void dispose() {
    // Verifique se o controlador foi inicializado antes de chamar dispose
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MedScan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.greenAccent,
            child: SizedBox(
              height: double.infinity,
              child: _controller.value.isInitialized
                  ? CameraPreview(_controller)
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: MaterialButton(
                    onPressed: () async {
                      if (!_controller.value.isInitialized) {
                        return;
                      }
                      if (_controller.value.isTakingPicture) {
                        return;
                      }

                      try {
                        await _controller.takePicture();
                        XFile file = await _controller.takePicture();

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePage(file),
                          ),
                        );
                      } on CameraException catch (e) {
                        print('Error taking picture: $e');
                        return;
                      }
                    },
                    color: Colors.greenAccent,
                    elevation: 5,
                    // Adiciona sombra ao redor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15.0), // Borda arredondada
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ajusta o tamanho do botão ao conteúdo
                      children: [
                        Icon(
                          Icons.camera_alt, // Ícone de câmera como exemplo
                          color: Colors.black,
                        ),
                        SizedBox(
                            width:
                            8), // Adiciona um espaço entre o ícone e o texto
                        Text(
                          'Capturar imagem',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}