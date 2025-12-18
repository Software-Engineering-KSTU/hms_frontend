import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'PatientProfileModel.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState
    extends BaseScreen<PatientProfileScreen, PatientProfileModel> {

  @override
  Widget buildBody(BuildContext context, PatientProfileModel model) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    model.avatar,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  model.fullName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Дата рождения: ${model.birthDate}",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 40),

                _navButton(context, "Мои записи", "/my-appointments"),
                _navButton(context, "История записей", "/history"),
                _navButton(context, "История страйков", "/strikes"),
                _navButton(context, "Оставить отзыв", "/review"),
                _navButton(context, "Медицинские рекомендации", "/advice"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            context.go(route); // ✅ ВАЖНО
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: Colors.blue.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
        ),
      ),
    );
  }
}
