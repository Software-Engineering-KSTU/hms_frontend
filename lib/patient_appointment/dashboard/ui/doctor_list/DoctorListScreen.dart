import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'DoctorListScreenModel.dart';

/// ВРЕМЕННАЯ модель для верстки.
/// ⚠️ Когда будет готов API — удалить и использовать модель из backend
class DummyDoctor {
  final int doctorId;
  final String doctorName;
  final String specialization;
  final String avatarAsset;

  DummyDoctor({
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    required this.avatarAsset,
  });
}

/// ВРЕМЕННЫЕ данные для верстки.
/// ⚠️ В будущем заменить на viewModel.doctors
final List<DummyDoctor> dummyDoctors = [
  DummyDoctor(
    doctorId: 1,
    doctorName: "Иванов Иван Иванович",
    specialization: "Терапевт",
    avatarAsset: "assets/images/doctor.jpg",
  ),
  DummyDoctor(
    doctorId: 2,
    doctorName: "Петрова Елена Сергеевна",
    specialization: "Кардиолог",
    avatarAsset: "assets/images/doctor_resume.jpg",
  ),
  DummyDoctor(
    doctorId: 3,
    doctorName: "Сидоров Алексей Петрович",
    specialization: "Невролог",
    avatarAsset: "assets/images/map_placeholder.png",
  ),
];

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState
    extends BaseScreen<DoctorListScreen, DoctorListScreenModel> {

  /// Переключатель между ListView и GridView
  bool isGrid = false;

  @override
  Widget buildBody(BuildContext context, DoctorListScreenModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [

                // ================= HEADER =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Врачи",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Кнопка переключения вида (список / сетка)
                    IconButton(
                      icon: Icon(
                        isGrid ? Icons.view_list : Icons.grid_view,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          isGrid = !isGrid;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= CONTENT =================
                /// ⚠️ Здесь сейчас используется dummyDoctors
                /// 🔁 Когда будет API:
                /// заменить dummyDoctors -> viewModel.doctors
                Expanded(
                  child: isGrid
                      ? _buildGrid(context)
                      : _buildList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= LIST VIEW =================
  /// Список врачей (вертикальный)
  Widget _buildList(BuildContext context) {
    return ListView.separated(
      itemCount: dummyDoctors.length, // заменить на viewModel.doctors.length
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {

        /// В будущем:
        /// final doctor = viewModel.doctors[index];
        final doctor = dummyDoctors[index];

        return InkWell(
          borderRadius: BorderRadius.circular(16),

          /// Навигация к странице врача
          /// ⚠️ doctorId должен приходить с backend
          onTap: () {
            context.push('/patient/dashboard/${doctor.doctorId}');
          },

          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                /// Аватар врача
                CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage(doctor.avatarAsset),
                ),

                const SizedBox(width: 20),

                /// ФИО + специализация
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.doctorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

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
    );
  }

  // ================= GRID VIEW =================
  /// Сетка врачей (карточки)
  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      itemCount: dummyDoctors.length, // заменить на viewModel.doctors.length
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // для web
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.85,//размер grid.view
      ),
      itemBuilder: (context, index) {
        final doctor = dummyDoctors[index];

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.push('/patient/dashboard/${doctor.doctorId}');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Column(
              children: [
                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 72,
                  backgroundImage: AssetImage(doctor.avatarAsset),
                ),

                const SizedBox(height: 24),

                Text(
                  doctor.doctorName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  doctor.specialization,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 40),

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
    );
  }

  /// Общий стиль карточек
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
