import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreen.dart';

import 'DoctorListScreenModel.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DoctorListScreenState();
  }
}

class DoctorListScreenState
    extends BaseScreen<DoctorListScreen, DoctorListScreenModel> {
  @override
  Widget buildBody(BuildContext context, DoctorListScreenModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC), // Светлый медицинский фон
      appBar: AppBar(
        title: const Text(
          "Наши специалисты",
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1976D2)),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: viewModel.doctors.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final doctor = viewModel.doctors[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                // Основное действие - переход к записи (Dashboard)
                onTap: () {
                  context.push('/patient/dashboard/${doctor.doctorId}');
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // 1. Аватар (Заглушка)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD), // Light Blue
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF1976D2), // Medical Blue
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // 2. Информация (Имя и Спец)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor.doctorName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Тег специализации
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                doctor.specialization,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF616161),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Кнопка "Инфо" (Резюме)
                      IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          color: Color(0xFFBDBDBD),
                        ),
                        tooltip: 'Подробнее о враче',
                        onPressed: () {
                          context.push('/doctor/resume/${doctor.doctorId}');
                        },
                      ),

                      // Стрелочка, указывающая на возможность перехода
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF1976D2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}