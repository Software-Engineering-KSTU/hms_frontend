import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/admin_panel/rep/DoctorRepository.dart';

class AdminEditResumeModel extends BaseScreenModel {
  final int doctorId;
  final DoctorResumeDto? initialData;

  AdminEditResumeModel({required this.doctorId, this.initialData});

  final DoctorRepository _repository = DoctorRepository();

  // --- ИСПРАВЛЕНИЕ: ПЕРЕОПРЕДЕЛЯЕМ ПОЛЕ ОШИБКИ ---
  @override
  String? errorMessage;

  // Контроллеры
  late TextEditingController stageController;
  late TextEditingController experienceController;
  late TextEditingController educationController;
  late TextEditingController certificatesController;
  late TextEditingController descriptionController;

  @override
  Future<void> onInitialization() async {
    // Инициализируем контроллеры данными, если они есть
    stageController = TextEditingController(text: initialData?.stage ?? '');
    experienceController = TextEditingController(text: initialData?.experienceYears.toString() ?? '');
    educationController = TextEditingController(text: initialData?.education ?? '');
    certificatesController = TextEditingController(text: initialData?.certificates ?? '');
    descriptionController = TextEditingController(text: initialData?.description ?? '');
  }

  @override
  void dispose() {
    stageController.dispose();
    experienceController.dispose();
    educationController.dispose();
    certificatesController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<bool> saveResume() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final int? exp = int.tryParse(experienceController.text);
      if (exp == null) {
        errorMessage = "Стаж должен быть числом";
        return false;
      }

      // Если в DTO поле photoUrl обязательное (String), а у нас может быть null,
      // нужно передать пустую строку или заглушку, если initialData?.photoUrl == null.
      // Если вы уже сделали photoUrl: String? в DTO, то код ниже корректен.
      final dto = DoctorResumeDto(
        id: initialData?.id ?? 0,
        doctorId: doctorId,
        stage: stageController.text,
        experienceYears: exp,
        education: educationController.text,
        certificates: certificatesController.text,
        description: descriptionController.text,
        photoUrl: initialData?.photoUrl ?? "", // Добавил ?? "" на случай, если поле required
      );

      if (initialData == null) {
        await _repository.createResume(doctorId, dto);
      } else {
        await _repository.updateResume(doctorId, dto);
      }

      return true;
    } catch (e) {
      errorMessage = "Ошибка сохранения: $e";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickAndUploadPhoto() async {
    print("Логика выбора файла и вызова _repository.uploadPhoto(doctorId, path)");
  }
}