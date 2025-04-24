import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sound_level_meter/feature/qrScanner/bloc/scanner/bloc/qr_scanner_bloc.dart';

@RoutePage()
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Длительность анимации
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Сканер QR-кодов'),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<QrScannerBloc, QrScannerState>(
            builder: (context, state) {
          if (state is QrScannerInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QrScannerLoaded) {
            return Stack(
              children: [
                MobileScanner(
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null) {
                        final String code = barcode.rawValue!;
                        print('QR-код обнаружен: $code');
                        Navigator.pop(context, code); // Возвращаемся с данными
                      }
                    }
                  },
                  errorBuilder: (context, error, child) {
                    return Center(
                      child: Text(
                        'Ошибка камеры: $error',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
                _buildOverlay(context),
              ],
            );
          } else if (state is QrScannerError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }
          return const SizedBox.shrink();
        }));
  }

  Widget _buildOverlay(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ),

        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Анимированная линия внутри рамки
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: 300 * _animation.value, // Движение вверх-вниз
                  child: Container(
                    width: 280,
                    height: 2,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
