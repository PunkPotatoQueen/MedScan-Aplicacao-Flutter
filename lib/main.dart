import 'package:camera/camera.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto3/screen/camera_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;

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
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
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
                            builder: (context) => ImagePreview(file),
                          ),
                        );
                      } on CameraException catch (e) {
                        print('Error taking picture: $e');
                        return;
                      }
                    },
                    color: Colors.white,
                    elevation: 5, // Adiciona sombra ao redor do botão
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
                          color: Colors.blue,
                        ),
                        SizedBox(
                            width:
                                8), // Adiciona um espaço entre o ícone e o texto
                        Text(
                          'Capturar imagem',
                          style: TextStyle(
                            color: Colors.blue,
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
