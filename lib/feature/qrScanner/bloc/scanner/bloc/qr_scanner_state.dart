part of 'qr_scanner_bloc.dart';

abstract class QrScannerState {
  const QrScannerState();
}

class QrScannerInitial extends QrScannerState {
  const QrScannerInitial();
}

class   QrScannerLoaded extends QrScannerState {
   final TechniqueDetails details;
   QrScannerLoaded(this.details);
}

class QrScannerError extends QrScannerState {
  final Object message;

  const QrScannerError(this.message);
}