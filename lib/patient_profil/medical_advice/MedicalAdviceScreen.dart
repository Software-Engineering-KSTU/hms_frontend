import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import '../widgets/StickyHeader.dart';
import 'MedicalAdviceModel.dart';

class MedicalAdviceScreen extends StatefulWidget {
  const MedicalAdviceScreen({super.key});

  @override
  State<MedicalAdviceScreen> createState() => _MedicalAdviceScreenState();
}

class _MedicalAdviceScreenState
    extends BaseScreen<MedicalAdviceScreen, MedicalAdviceModel> {

  @override
  Widget buildBody(BuildContext context, MedicalAdviceModel model) {
    return StickyHeaderScaffold(
      title: "Базовые медицинские советы",
      body: Padding(
        padding: const EdgeInsets.only(bottom: 200,left: 200,right: 200,top: 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.4,
            ),
            itemCount: model.tips.length,
            itemBuilder: (context, index) {
              final tip = model.tips[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: _card(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tip.icon,
                      size: 48,
                      color: Colors.blue.shade600,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tip.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  BoxDecoration _card() {
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
