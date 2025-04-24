import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_level_meter/feature/qrScanner/model/technique_details_model.dart';

import '../repository/scanner_repository.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc(this._repository) : super(const QrScannerInitial()) {
    on<QrScannerDetected>((event, emit) async {
      emit(QrScannerInitial());
      try {
        final details = await _repository.vfetchTechniqueDetails(event.code);
        emit(QrScannerLoaded(details));
      } catch (e) {
             emit(QrScannerError('Не удалось загрузить данные по QR: $e'));
      }
    });
  }

  final ScannerRepository _repository;
}
