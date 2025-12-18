import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // <--- Нужно добавить в pubspec.yaml
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/admin_panel/rep/DoctorRepository.dart';

class AdminEditResumeModel extends BaseScreenModel {
  final int doctorId;
  final DoctorResumeDto? initialData;

  AdminEditResumeModel({required this.doctorId, this.initialData}) {
    _initControllers();
    // Инициализируем текущее фото при старте
    currentPhotoUrl = initialData?.photoUrl;
  }

  final DoctorRepository _repository = DoctorRepository();
  final ImagePicker _picker = ImagePicker(); // Инструмент для галереи

  // Поле для отображения фото (изменяемое)
  String? currentPhotoUrl;

  @override
  String? errorMessage;

  // Контроллеры
  late TextEditingController stageController;
  late TextEditingController experienceController;
  late TextEditingController educationController;
  late TextEditingController certificatesController;
  late TextEditingController descriptionController;

  void _initControllers() {
    stageController = TextEditingController(text: initialData?.stage ?? '');
    experienceController = TextEditingController(text: initialData?.experienceYears?.toString() ?? '');
    educationController = TextEditingController(text: initialData?.education ?? '');
    certificatesController = TextEditingController(text: initialData?.certificates ?? '');
    descriptionController = TextEditingController(text: initialData?.description ?? '');
  }

  @override
  Future<void> onInitialization() async {
    // Пусто, так как инициализация в конструкторе
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

  // --- ЛОГИКА ЗАГРУЗКИ ФОТО ---
  Future<void> pickAndUploadPhoto() async {
    try {
      // 1. Открываем галерею
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) return; // Пользователь отменил выбор

      isLoading = true;
      notifyListeners();

      // 2. Загружаем на сервер
      // Метод uploadPhoto возвращает URL загруженного файла
      final String newUrl = await _repository.uploadPhoto(doctorId, image.path);

      // 3. Обновляем UI
      currentPhotoUrl = newUrl;

    } catch (e) {
      errorMessage = "Не удалось загрузить фото: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
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

      final dto = DoctorResumeDto(
        id: initialData?.id ?? 0,
        doctorId: doctorId,
        stage: stageController.text,
        experienceYears: exp,
        education: educationController.text,
        certificates: certificatesController.text,
        description: descriptionController.text,
        photoUrl: currentPhotoUrl ?? "", // Отправляем актуальную ссылку
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
}