import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/core/utils/widgets/app_bottom_bar.dart';
import 'package:untitled1/features/home/presentation/pages/dashboard/ai_start_page.dart';

import 'package:untitled1/features/home/presentation/pages/dashboard/home_view.dart';
import 'package:untitled1/features/home/presentation/pages/expense/money_and_debt_view.dart';
import 'package:untitled1/features/home/presentation/pages/dashboard/vault_view.dart';
import 'package:untitled1/features/home/presentation/providers/home_provider.dart';

class MainDashboard extends ConsumerWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);

    final List<Widget> screens = [
      const HomeView(),
      const VaultView(),
      const MoneyAndDebtView(),
      const AiStartPage(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: provider.selectedTab, children: screens),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: const AppBottomBar(),
          ),
        ],
      ),
    );
  }
}
