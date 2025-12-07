import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Контакты клиники",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Вы можете связаться с нами или найти клинику по адресу ниже.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [

                            _infoCard(
                              title: "Адрес",
                              icon: Icons.location_on_rounded,
                              content:
                              "г. Бишкек, ул. Медицинская 12, бизнес-центр «Здоровье», 2 этаж",
                            ),

                            const SizedBox(height: 20),

                            _infoCard(
                              title: "График работы",
                              icon: Icons.access_time_filled_rounded,
                              content:
                              "Пн–Пт: 08:00 – 20:00\nСб: 09:00 – 17:00\nВс: выходной",
                            ),

                            const SizedBox(height: 20),

                            _infoCard(
                              title: "Телефоны",
                              icon: Icons.phone_in_talk_rounded,
                              content:
                              "+996 555 123 456\n+996 709 987 654",
                            ),

                            const SizedBox(height: 20),

                            _infoCard(
                              title: "Эл. почта",
                              icon: Icons.email_rounded,
                              content:
                              "info@clinic.kg\nsupport@clinic.kg",
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade600,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.send_rounded, color: Colors.white),
                              label: const Text(
                                "Написать нам",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),

                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/images/map_placeholder.png",
                            fit: BoxFit.cover,
                            height: 500,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
