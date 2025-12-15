import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';

class VisitedDoctorUI {
  final String doctorName;
  final String specialty;
  final DateTime visitDate;

  VisitedDoctorUI({
    required this.doctorName,
    required this.specialty,
    required this.visitDate,
  });
}

class LeaveReviewModel extends BaseScreenModel {
  List<VisitedDoctorUI> visitedDoctors = [];
  VisitedDoctorUI? selectedDoctor;
  double rating = 5;
  final TextEditingController reviewController = TextEditingController();

  @override
  Future<void> onInitialization() async{
    // MOCK: посещённые врачи
    visitedDoctors = [
      VisitedDoctorUI(
        doctorName: "Иванов И.И.",
        specialty: "Терапевт",
        visitDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
      VisitedDoctorUI(
        doctorName: "Петрова А.А.",
        specialty: "Кардиолог",
        visitDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
    notifyListeners();
  }

  void selectDoctor(VisitedDoctorUI doctor) {
    selectedDoctor = doctor;
    notifyListeners();
  }

  void setRating(double value) {
    rating = value;
    notifyListeners();
  }

  void submitReview() {
    // тут будет API
    debugPrint("Врач: ${selectedDoctor?.doctorName}");
    debugPrint("Оценка: $rating");
    debugPrint("Отзыв: ${reviewController.text}");
  }
}
