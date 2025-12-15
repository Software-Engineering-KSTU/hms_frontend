import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import '../widgets/StickyHeader.dart';
import 'LeaveReviewModel.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({super.key});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState
    extends BaseScreen<LeaveReviewScreen, LeaveReviewModel> {

  @override
  Widget buildBody(BuildContext context, LeaveReviewModel model) {
    return StickyHeaderScaffold(
      title: "Оставить отзыв врачу",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: model.selectedDoctor == null
                ? _doctorSelection(model)
                : _reviewForm(model),
          ),
        ),
      ),
    );
  }

  // ================= ВЫБОР ВРАЧА =================
  Widget _doctorSelection(LeaveReviewModel model) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: model.visitedDoctors.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final doctor = model.visitedDoctors[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => model.selectDoctor(doctor),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Icon(Icons.medical_services,
                    color: Colors.blue.shade600),
                const SizedBox(width: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.doctorName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      doctor.specialty,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Приём: ${DateFormat('dd.MM.yyyy').format(doctor.visitDate)}",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),

                const Spacer(),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.blue),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= ФОРМА ОТЗЫВА =================
  Widget _reviewForm(LeaveReviewModel model) {
    final doctor = model.selectedDoctor!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Отзыв о враче",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.doctorName,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                doctor.specialty,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              const Text("Оценка", style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                activeColor: Colors.blue,
                value: model.rating,
                min: 1,
                max: 5,
                divisions: 4,
                label: model.rating.toString(),
                onChanged: model.setRating,
              ),

              const SizedBox(height: 12),
              TextField(
                controller: model.reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Опишите ваш опыт посещения...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: model.submitReview,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: Colors.blue.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Отправить отзыв",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
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
