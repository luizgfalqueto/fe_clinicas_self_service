// ignore_for_file: prefer_const_constructors

import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_form_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/widget/lab_clinicas_self_services_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with PatientFormController {
  final formKey = GlobalKey<FormState>();
  final selfServiceController = Injector.get<SelfServiceController>();

  late bool patientFounded;
  late bool enableForm;

  @override
  void initState() {
    final SelfServiceModel(:patient) = selfServiceController.model;

    patientFounded = patient != null;
    enableForm = !patientFounded;

    initializeForm(patient);

    super.initState();
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasSelfServicesAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: patientFounded,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: patientFounded,
                    replacement: const Text(
                      'Cadastro não encontrado',
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                    child: const Text(
                      'Cadastro encontrado',
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: patientFounded,
                    replacement: const Text(
                      'Preencha o formulário abaixo para fazer o seu cadastro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicasTheme.blueColor,
                      ),
                    ),
                    child: const Text(
                      'Confirma os dados do seu cadastro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicasTheme.blueColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    validator: Validatorless.required('Nome obrigatório'),
                    decoration: const InputDecoration(
                      label: Text('Nome Paciente'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Eamil obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: phoneEC,
                    validator: Validatorless.required('Telefone obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      label: Text('Telefone de contato'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    validator: Validatorless.required('CPF obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      label: Text('Digite seu CPF'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: cepEC,
                    validator: Validatorless.required('CEP obrigatório'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      label: Text('CEP'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: streetEC,
                          validator:
                              Validatorless.required('Endereço obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Endereço'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: numberEC,
                          validator:
                              Validatorless.required('Número obrigatório'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            label: Text('Número'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: complementEC,
                          decoration: const InputDecoration(
                            label: Text('Complemento'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: stateEC,
                          validator:
                              Validatorless.required('Estado obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Estado'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: cityEC,
                          validator:
                              Validatorless.required('Cidade obrigatória'),
                          decoration: const InputDecoration(
                            label: Text('Cidade'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: districtEC,
                          validator:
                              Validatorless.required('Bairro obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Bairro'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    decoration: const InputDecoration(
                      label: Text('Responsável'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumberEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      label: Text('Documento de identificação'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Visibility(
                          visible: !patientFounded,
                          replacement: Text('Salvar e Continuar'),
                          child: Text('Cadastrar'),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  enableForm = true;
                                });
                              },
                              child: const Text('Editar'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Continuar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
