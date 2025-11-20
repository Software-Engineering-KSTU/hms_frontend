import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/home/ui/PatientStateModel.dart';

class PatientStateScreen extends StatelessWidget {
  const PatientStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PatientStateModel>();

    if (model.isLoading || model.patient == null && model.error == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (model.error != null) {
      return Center(child: Text('Ошибка: ${model.error}'));
    }

    final patient = model.patient!;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Важно: ShellRoute уже даёт AppBar, поэтому тут можно без appBar,
      // иначе будет двойной. Если нужен отдельный — можно оставить.
      backgroundColor: const Color(0xfff4f4fb),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Шапка
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      patient.fullName,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _StatusChip(status: patient.status),
                    const Spacer(),
                    Text('ID: ${patient.id}', style: textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${patient.age} лет · палата ${patient.ward} · ${patient.diagnosis}',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),

                // Основной блок
                Expanded(
                  child: Row(
                    children: [
                      // Витал-сигналы
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Жизненные показатели',
                                    style: textTheme.titleMedium),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 24,
                                  runSpacing: 16,
                                  children: [
                                    _VitalTile(
                                      label: 'Температура',
                                      value:
                                      '${patient.temperature.toStringAsFixed(1)} °C',
                                    ),
                                    _VitalTile(
                                      label: 'Пульс',
                                      value: '${patient.pulse} уд/мин',
                                    ),
                                    _VitalTile(
                                      label: 'Давление',
                                      value:
                                      '${patient.pressureSys}/${patient.pressureDia} мм рт. ст.',
                                    ),
                                    _VitalTile(
                                      label: 'SpO₂',
                                      value:
                                      '${patient.spo2.toStringAsFixed(0)} %',
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // добавить историю показателей
                                      },
                                      child:
                                      const Text('История показателей'),
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () {
                                        model.load(); // перезагрузить
                                      },
                                      child: const Text('Обновить'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Назначения + комментарий
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('Последние назначения',
                                          style: textTheme.titleMedium),
                                      const SizedBox(height: 12),
                                      Expanded(
                                        child: ListView(
                                          children: const [
                                            _AppointmentRow(
                                              time: 'Сегодня · 10:30',
                                              text:
                                              'Измерение давления каждые 4 часа',
                                            ),
                                            _AppointmentRow(
                                              time: 'Сегодня · 09:00',
                                              text:
                                              'Антибиотикотерапия, курс 5 дней',
                                            ),
                                            _AppointmentRow(
                                              time: 'Вчера · 18:00',
                                              text:
                                              'Контроль температуры перед сном',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 70,
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Комментарий врача:',
                                        style: textTheme.bodyMedium,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Состояние стабильное, отмечается положительная динамика.',
                                          style: textTheme.bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      TextButton(
                                        onPressed: () {
                                          // открытие новой страницы с полным описанием врача, примерным лечением
                                        },
                                        child:
                                        const Text('Открыть протокол'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'критическое':
        bg = Colors.red.shade50;
        fg = Colors.red.shade700;
        break;
      case 'требует наблюдения':
        bg = Colors.orange.shade50;
        fg = Colors.orange.shade700;
        break;
      default:
        bg = Colors.green.shade50;
        fg = Colors.green.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(status, style: TextStyle(color: fg)),
    );
  }
}

class _VitalTile extends StatelessWidget {
  final String label;
  final String value;

  const _VitalTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentRow extends StatelessWidget {
  final String time;
  final String text;

  const _AppointmentRow({required this.time, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(time, style: textTheme.bodySmall),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
