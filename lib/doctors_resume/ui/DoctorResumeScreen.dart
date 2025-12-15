import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/base/BaseScreen.dart';

import 'DoctorResumeModel.dart';

class DoctorResumeScreen extends StatefulWidget {
  const DoctorResumeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return DoctorResumeScreenState();
  }
}

class DoctorResumeScreenState
    extends BaseScreen<DoctorResumeScreen, DoctorResumeModel> {
  @override
  Widget buildBody(BuildContext context, DoctorResumeModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Builder(
            builder: (context) {
              if (viewModel.isLoading) {
                return const CircularProgressIndicator();
              } else {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: viewModel.doctorResume.photoUrl,
                                placeholder: (ctx, url) => CircularProgressIndicator(),
                                errorWidget: (ctx, url, error) => Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              viewModel.doctorInfo.doctorName,
                              maxLines: 1,
                              minFontSize: 22,
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Chip(
                              backgroundColor: Colors.blue.shade50,
                              label: Text(
                                viewModel.doctorInfo.specialization,
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Icon(Icons.badge, color: Colors.blue.shade600),
                                const SizedBox(width: 8),
                                Text(
                                  viewModel.doctorResume.stage,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                Icon(Icons.school, color: Colors.blue.shade600),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    viewModel.doctorResume.education,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            const Text(
                              "О враче",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              viewModel.doctorResume.description,
                              style: const TextStyle(fontSize: 18, height: 1.5),
                            ),

                            const SizedBox(height: 40),

                            SizedBox(
                              width: 260,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push('/patient/dashboard/${viewModel.idDoctor}');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  backgroundColor: Colors.blue.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Text(
                                  "Записаться на приём",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
