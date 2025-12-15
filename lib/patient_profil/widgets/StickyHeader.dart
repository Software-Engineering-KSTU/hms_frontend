import 'package:flutter/material.dart';

class StickyHeaderScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const StickyHeaderScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Align(alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: false,
          ),

          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
