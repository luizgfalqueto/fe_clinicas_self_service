import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class FindPatient extends StatelessWidget {

  const FindPatient({ super.key });

   @override
   Widget build(BuildContext context) {
    Injector.get<SelfServiceController>().debug();
       return Scaffold(
           appBar: AppBar(title: const Text('Find Patient'),),
           body: Container(),
       );
  }
}