import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentForm extends StatefulWidget {
  final String patientName;     // Имя пациента (из backend)
  final int patientId;          // При необходимости

  const AppointmentForm({
    super.key,
    required this.patientName,
    required this.patientId,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController selfTreatmentController = TextEditingController();

  Future<void> pickDateTime() async {
    DateTime now = DateTime.now();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final selected = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    dateTimeController.text =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/doctor_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: const Color(0xD0CBEAFF),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildField(label: "Имя пациента", value: widget.patientName),
                const SizedBox(height: 12),

                _buildInput(
                  label: "Дата и время",
                  controller: dateTimeController,
                  readOnly: true,
                  onTap: pickDateTime,
                ),
                const SizedBox(height: 12),

                _buildBigInput(
                  label: "Симптомы пациента",
                  controller: symptomsController,
                ),
                const SizedBox(height: 12),

                _buildBigInput(
                  label: "Методы принятые для самолечения",
                  controller: selfTreatmentController,
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: 200,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      final dto = {
                        "doctorId": widget.patientId, // Пример, поправь под API
                        "dateTime": dateTimeController.text,
                        "symptomsDescribedByPatient": symptomsController.text,
                        "selfTreatmentMethodsTaken": selfTreatmentController.text,
                      };

                      print(dto);
                    },
                    child: const Text("Отправить"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "$label: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: _dec(label),
    );
  }

  Widget _buildBigInput({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: _dec(label),
    );
  }

  InputDecoration _dec(String label) {
    return InputDecoration(
      hintText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }
}
