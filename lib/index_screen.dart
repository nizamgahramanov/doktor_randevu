
import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/screens.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/core/widgets/connectivity_aware_display.dart';
import 'package:doktor_randevu/core/widgets/no_connectivity_indicator.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/presentation/pages/booking_screen.dart';
import 'package:doktor_randevu/feature/client/presentation/pages/client_screen.dart';
import 'package:doktor_randevu/feature/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/constant/assets.dart';


class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();

  const IndexScreen({
    Key? key,
    this.index=0

  }) : super(key: key);
  final int index;
}

class _IndexScreenState extends State<IndexScreen> {
  final Style _style = sl<Style>();
  int selectedIndex = 0;

  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  Widget currentScreen = const DashboardScreen();
  late List<Widget> screens = [
    const DashboardScreen(),
    const BookingScreen(),
    const ClientScreen(showArrowButton:false, showContinueButton:false),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index; // Use the passed index
    currentScreen = screens[selectedIndex]; // Set the initial screen based on the index
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _backPressed();
      },
      child: ConnectivityAwareDisplay(
        whenNotConnected: NoConnectivityIndicator(),
        whenConnected: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          bottomNavigationBar: _buildBottomBar(),
          body: PageStorage(
            bucket: _pageStorageBucket,
            child: currentScreen,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Screens.service, arguments: Conclusion(title:AppLocalizations.of(context)!.conclusion, isBookInfo: false));
            },
            backgroundColor: _style.color(color: 'main_color'),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }

  Future<bool> _backPressed() async {
    if (selectedIndex != 0) {
      return false;
    } else {
      return false;
    }
  }

  _buildBottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(), // Creates a notch for FAB
      notchMargin: 6.0,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: _style.color(color: 'main_color'),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.home,
              colorFilter: ColorFilter.mode(
                _style.color(color: selectedIndex == 0 ? 'main_color' : 'grey_text_color'),
                BlendMode.srcIn,
              ),
            ),
            label: 'Randevu',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.meeting,
              colorFilter: ColorFilter.mode(
                _style.color(color: selectedIndex == 1 ? 'main_color' : 'grey_text_color'),
                BlendMode.srcIn,
              ),
            ),
            label:  AppLocalizations.of(context)!.calendar,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.patient,
              colorFilter: ColorFilter.mode(
                _style.color(color: selectedIndex == 2 ? 'main_color' : 'grey_text_color'),
                BlendMode.srcIn,
              ),
            ),
            label: AppLocalizations.of(context)!.patient,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      currentScreen = screens[index];
    });
  }
}
