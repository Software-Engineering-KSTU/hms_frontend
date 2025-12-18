import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../widgets/StickyHeader.dart';
import 'PatientHistoryAppointmentModel.dart';
import 'package:hmsweb/base/BaseScreen.dart';

class PatientHistoryAppointmentScreen extends StatefulWidget {
  const PatientHistoryAppointmentScreen({super.key});

  @override
  State<PatientHistoryAppointmentScreen> createState() =>
      _PatientHistoryAppointmentScreenState();
}

class _PatientHistoryAppointmentScreenState extends BaseScreen<
    PatientHistoryAppointmentScreen, PatientHistoryAppointmentModel> {

  @override
  Widget buildBody(
      BuildContext context, PatientHistoryAppointmentModel viewModel) {

    return StickyHeaderScaffold(
      title: "История записей",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.separated(
              itemCount: viewModel.appointments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final appointment = viewModel.appointments[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _showDetails(context, appointment),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: _cardDecoration(),
                    child: Row(
                      children: [
                        Icon(Icons.event, color: Colors.blue.shade600),
                        const SizedBox(width: 16),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text("Запись", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                            Text(
                              DateFormat('dd.MM.yyyy')
                                  .format(appointment.dateTime),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('HH:mm')
                                  .format(appointment.dateTime),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ================= DIALOG =================
  void _showDetails(
      BuildContext context, PatientAppointmentUI appointment) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Детали приёма"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow("Врач", appointment.doctorName),
            _infoRow("Состояние", appointment.patientState),
            _infoRow("Лечение", appointment.treatment),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Закрыть"),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
