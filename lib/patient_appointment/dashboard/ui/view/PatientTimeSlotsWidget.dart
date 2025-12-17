// import 'package:flutter/material.dart';
//
// import 'StatusRegistration.dart';
//
// class TimeSlotsWidget extends StatelessWidget {
//
//   final Map<String, StatusRegistration> status;
//
//   TimeSlotsWidget({
//     super.key,
//     required this.status,
//   });
//
//   final List<String> times = [
//     "08:00","08:20","08:40","09:00",
//     "09:20","09:40","10:00","10:20",
//     "10:40","11:00","11:20","11:40",
//     "12:00","12:20","12:40","13:00",
//     "13:20","13:40",
//   ];
//
//   Color getColor(String time) {
//     switch (status[time]) {
//       case StatusRegistration.mine: return Colors.blue;
//       case StatusRegistration.busy: return Colors.red;
//       default: return Colors.green;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//
//         // Заголовок
//         Text(
//           "Выберите время",
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//         SizedBox(height: 16),
//
//         // Легенда
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             legendDot(Colors.red, "Занято"),
//             SizedBox(width: 20),
//             legendDot(Colors.green, "Свободно"),
//             SizedBox(width: 20),
//             legendDot(Colors.blue, "Ваша запись"),
//           ],
//         ),
//
//         SizedBox(height: 20),
//
//         // Сетка кнопок
//         Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           children: times.map((time) {
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
//               decoration: BoxDecoration(
//                 color: getColor(time),
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Text(
//                 time,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget legendDot(Color color, String text) {
//     return Row(
//       children: [
//         Container(
//           width: 14,
//           height: 14,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//         SizedBox(width: 6),
//         Text(
//           text,
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'StatusRegistration.dart';

class TimeSlotsWidget extends StatelessWidget {

  final Map<String, StatusRegistration> status;
  final Function(String time) onTimeSelected;

  TimeSlotsWidget({
    super.key,
    required this.status,
    required this.onTimeSelected,
  });

  final List<String> times = [
    "08:00","08:20","08:40","09:00",
    "09:20","09:40","10:00","10:20",
    "10:40","11:00","11:20","11:40",
    "12:00","12:20","12:40","13:00",
    "13:20","13:40",
  ];

  // ЦВЕТОВАЯ ПАЛИТРА
  Color getColor(String time, StatusRegistration? statusEnum) {
    switch (statusEnum) {
      case StatusRegistration.mine:
      // ВЕРНУЛИ СИНИЙ (Medical Blue)
        return const Color(0xFF1976D2);
      case StatusRegistration.busy:
        return const Color(0xFFEF5350); // Мягкий красный (Занято)
      default:
        return const Color(0xFF4CAF50); // Зеленый (Свободно)
    }
  }

  Color getTextColor(StatusRegistration? statusEnum) {
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        const Padding(
          padding: EdgeInsets.only(bottom: 24.0),
          child: Text(
            "Доступное время",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
        ),

        // Легенда
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              legendDot(const Color(0xFF4CAF50), "Свободно"),
              legendDot(const Color(0xFFEF5350), "Занято"),
              // ВЕРНУЛИ СИНИЙ В ЛЕГЕНДУ
              legendDot(const Color(0xFF1976D2), "Ваша запись"),
            ],
          ),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 12,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: times.map((time) {

              final currentStatus = status[time];
              final bgColor = getColor(time, currentStatus);
              final txtColor = getTextColor(currentStatus);
              final isBusy = currentStatus == StatusRegistration.busy;

              return InkWell(
                onTap: () => onTimeSelected(time),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      if (!isBusy)
                        BoxShadow(
                          color: bgColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                    ],
                    border: isBusy
                        ? Border.all(color: Colors.red.shade100, width: 1)
                        : null,
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget legendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
              color: Color(0xFF757575),
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}