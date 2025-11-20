class PatientStateDto {
  final String id;
  final String fullName;
  final int age;
  final String diagnosis;
  final String ward;
  final String status; // Стабильное / Критическое и т.п.
  final double temperature;
  final int pulse;
  final int pressureSys;
  final int pressureDia;
  final double spo2;

  const PatientStateDto({
    required this.id,
    required this.fullName,
    required this.age,
    required this.diagnosis,
    required this.ward,
    required this.status,
    required this.temperature,
    required this.pulse,
    required this.pressureSys,
    required this.pressureDia,
    required this.spo2,
  });


  factory PatientStateDto.mock() {
    return const PatientStateDto(
      id: 'времееный айди',
      fullName: 'Иванов Иван Иванович',
      age: 45,
      diagnosis: 'Пневмония',
      ward: '312',
      status: 'Стабильное',
      temperature: 36.8,
      pulse: 78,
      pressureSys: 120,
      pressureDia: 80,
      spo2: 97,
    );
  }
}
