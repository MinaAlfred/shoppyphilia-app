// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/modules/home/view/home_screen.dart';
import 'package:shoppyphilia/modules/profile/veiw/profile_screen.dart';
import 'package:shoppyphilia/modules/settings/veiw/settings_screen.dart';

class MainTabPages extends StatelessWidget {
  int pageIndex;
  MainTabPages({Key key, this.pageIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _HomeTabPagesProviderBody(this.pageIndex);
  }
}

class _HomeTabPagesProviderBody extends StatefulWidget {
  final int pageIndex;
  const _HomeTabPagesProviderBody(this.pageIndex);
  @override
  State<StatefulWidget> createState() {
    return _HomeTabPagesProviderBodyState(this.pageIndex);
  }
}

class _HomeTabPagesProviderBodyState extends State<_HomeTabPagesProviderBody> {
  int pageIndex;
  _HomeTabPagesProviderBodyState(this.pageIndex);
  List<Widget> _pages = [];
  List<Widget> tabPages = [HomeScreen(), ProfileScreen(), SettingsScreen()];
  @override
  void initState() {
    _pages.add(ProfileScreen());
    _pages.add(HomeScreen());
    _pages.add(SettingsScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: _pages[pageIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
              currentIndex: pageIndex,
              backgroundColor: MyColors.textFieldBackground,
              selectedItemColor: MyColors.blackColor,
              onTap: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 1.5),
                      child: Icon(
                        Icons.person,
                        size: 24,
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 1.5),
                      child: Icon(Icons.settings_outlined),
                    ),
                    label: '')
              ]),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: MyColors.textFieldBackground,
          child: Icon(Icons.home,
              color: pageIndex == 1 ? MyColors.blackColor : Colors.grey[700]),
          onPressed: () => setState(() {
            pageIndex = 1;
          }),
        ),
      ),
    );
  }
}
