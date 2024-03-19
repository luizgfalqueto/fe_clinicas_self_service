import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {

  final PatientRepository _patientRepository;
  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  FindPatientController({required PatientRepository patientRepository})
      : _patientRepository = patientRepository;

  bool? get patientNotFound => _patientNotFound();
  PatientModel? get patient => _patient();

  Future<void> findPatientByDocument(String document) async {
    final patientResult =
        await _patientRepository.findPatientByDocument(document);

    bool patientNotFound;
    PatientModel? patient;

    switch (patientResult) {
      case Right(value: PatientModel model?):
        patientNotFound = false;
        patient = model;
        break;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
        break;
      case Left(value: _):
        showError('Erro ao buscar paciente');
        return;
    }

    batch(() {
      _patient.forceUpdate(patient);
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }

  void continueWithoutDocument() {
    batch(() => {
      _patient.value = null,
      _patientNotFound.forceUpdate(true)
    });
  }
}
