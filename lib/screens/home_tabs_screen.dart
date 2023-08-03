/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'package:app/providers/auth.dart';
import 'package:app/providers/user.dart';
import 'package:app/providers/scan.dart';
import 'package:app/theme/theme.dart';

import 'dashboard.dart';
import 'app_bar.dart';
import 'out_in_store.dart';
import 'inventory.dart';

class HomeTabsScreen extends StatefulWidget {
  static const routeName = '/dashboard2';

  @override
  _HomeTabsScreenState createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen>
    with SingleTickerProviderStateMixin {
  late Future<void> _initialData;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Loading data here, since the build method can be called more than once
    _initialData = _loadEntries();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _screenList = [DashboardScreen(), OutInStore(), Inventory()];
  final _tabNames = ['设备', '出入库', '盘点'];

  /// Load initial data from the server
  Future<void> _loadEntries() async {
    final authProvider = context.read<AuthProvider>();
    final userProvider = context.read<UserProvider>();
    final ScanMethod = context.read<ScanProvider>();

    if (!authProvider.dataInit) {
      // Base data
      log('Loading base data');
      await Future.wait([
        authProvider.setServerVersion(),
        ScanMethod.getType(),
        userProvider.fetchAndSetProfile(),
      ]);

      // Plans, weight and gallery
      log('Loading plans, weight, measurements and gallery');
      await Future.wait([]);

      // Current nutritional plan
      log('Loading current nutritional plan');

      // Current workout plan
      log('Loading current workout plan');
    }

    authProvider.dataInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: SizedBox(
                      height: 70,
                      child: RiveAnimation.asset(
                        'assets/animations/wger_logo.riv',
                        animations: ['idle_loop2'],
                      ),
                    ),
                  ),
                  Text(
                    '加载...',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: _screenList.elementAt(_selectedIndex),
            appBar: MainAppBar(_tabNames[_selectedIndex],
                context.read<UserProvider>().profile!),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.house,
                    size: 20,
                  ),
                  label: _tabNames[0],
                ),
                BottomNavigationBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.rightLeft,
                    size: 20,
                  ),
                  label: _tabNames[1],
                ),
                BottomNavigationBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.rotate,
                    size: 20,
                  ),
                  label: _tabNames[2],
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: wgerPrimaryColorLight,
              backgroundColor: wgerPrimaryColor,
              onTap: _onItemTapped,
              showUnselectedLabels: false,
            ),
          );
        }
      },
    );
  }
}
//center_focus_strong
//center_focus_weak
//document_scanner
//fit_screen
//qr_code_scanner
//settings_remote
