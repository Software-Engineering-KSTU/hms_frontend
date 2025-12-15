import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';

class MedicalAdviceModel extends BaseScreenModel {
  final List<MedicalAdviceItem> tips = [
    MedicalAdviceItem(Icons.local_drink, "Пейте не менее 2 литров воды в день"),
    MedicalAdviceItem(Icons.bedtime, "Спите не менее 7–8 часов"),
    MedicalAdviceItem(Icons.directions_walk, "Гуляйте на свежем воздухе каждый день"),
    MedicalAdviceItem(Icons.fitness_center, "Занимайтесь физической активностью"),
    MedicalAdviceItem(Icons.fastfood_outlined, "Сократите употребление фастфуда"),
    MedicalAdviceItem(Icons.restaurant, "Питайтесь регулярно и сбалансировано"),
    MedicalAdviceItem(Icons.monitor_heart, "Следите за артериальным давлением"),
    MedicalAdviceItem(Icons.smoke_free, "Избегайте курения"),
    MedicalAdviceItem(Icons.local_hospital, "Проходите регулярные медосмотры"),
    MedicalAdviceItem(Icons.self_improvement, "Избегайте стресса и переутомления"),
  ];

  @override
  Future<void> onInitialization() async {}
}

class MedicalAdviceItem {
  final IconData icon;
  final String text;

  MedicalAdviceItem(this.icon, this.text);
}
