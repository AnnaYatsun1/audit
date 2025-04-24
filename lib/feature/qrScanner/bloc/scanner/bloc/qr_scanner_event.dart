part of 'qr_scanner_bloc.dart';

abstract class QrScannerEvent {}

class QrScannerStarted extends QrScannerEvent {}
class QrScannerDetected extends QrScannerEvent {
    final String code;

  QrScannerDetected(this.code);

}
