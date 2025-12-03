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
    return Builder(
      builder: (context) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
                maxHeight: 600,
              ),
              child: ListView.builder(
                itemCount: viewModel.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = viewModel.doctors[index];
                  return Card(
                      child: ListTile(
                        onTap: () {
                          context.push('/patient/dashboard/${doctor.doctorId}');
                        },
                        title: Text(doctor.doctorName.toString()),
                        subtitle: Text(doctor.specialization.toString()),
                      ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
