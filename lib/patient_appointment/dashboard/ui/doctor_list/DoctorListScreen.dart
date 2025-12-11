import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreen.dart';

import 'DoctorListScreenModel.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorListScreenState();
  }
}

class DoctorListScreenState
    extends BaseScreen<DoctorListScreen, DoctorListScreenModel> {
  @override
  Widget buildBody(BuildContext context, DoctorListScreenModel viewModel) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          final double availableHeight = constraints.maxHeight;
          final double listHeight = availableHeight > 750 ? 750 : availableHeight;

          return Container(
            color: Colors.white,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            height: listHeight,

            child: ListView.builder(
              itemCount: viewModel.doctors.length,
              itemBuilder: (context, index) {
                final doctor = viewModel.doctors[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.push('/patient/dashboard/${doctor.doctorId}');
                    },
                    title: Text(doctor.doctorName),
                    subtitle: Text(doctor.specialization),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
