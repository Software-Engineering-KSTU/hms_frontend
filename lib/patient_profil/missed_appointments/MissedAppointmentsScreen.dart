import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import '../widgets/StickyHeader.dart';
import 'MissedAppointmentsModel.dart';

class MissedAppointmentsScreen extends StatefulWidget {
  const MissedAppointmentsScreen({super.key});

  @override
  State<MissedAppointmentsScreen> createState() =>
      _MissedAppointmentsScreenState();
}

class _MissedAppointmentsScreenState
    extends BaseScreen<MissedAppointmentsScreen, MissedAppointmentsModel> {

  @override
  Widget buildBody(BuildContext context, MissedAppointmentsModel model) {
    return StickyHeaderScaffold(
      title: "Вы пропустили",
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.missed.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final m = model.missed[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _card(),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red),
                      const SizedBox(width: 16),
                      Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(m.dateTime),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(m.doctor),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _card() => BoxDecoration(
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
