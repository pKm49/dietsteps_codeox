import 'package:dietsteps/feature_modules/my_subscription/ui/pages/meal_calendar.page.my_subscription.dart';
import 'package:dietsteps/feature_modules/profile/controllers/profile.controller.dart';
import 'package:dietsteps/feature_modules/profile/ui/pages/my_profile.page.profile.dart';
import 'package:dietsteps/home.page.core.dart';
import 'package:dietsteps/shared_module/constants/style_params.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LandingPage_Core extends StatefulWidget {
  const LandingPage_Core({super.key});

  @override
  State<LandingPage_Core> createState() => _LandingPage_CoreState();
}

class _LandingPage_CoreState extends State<LandingPage_Core>   with TickerProviderStateMixin{

   final profileController = Get.find<ProfileController>();
  final sharedController = Get.find<SharedController>();

  List<int> tabHistory = [];
  late TabController _tabController;
  int _currentIndex = 0;
  bool isConnectivityVisible = false;
  bool isProfileCompletionAsked = false;
  bool isFirstLaunch = true;

  List<Widget> _tabList = [
    HomePage_Core(),
    MealCalendarPage_MySubscription(),
    MyProfilePage_Profile()
  ];


  List<BottomNavigationBarItem> bottomNavigationBarItemsThree = [
    const BottomNavigationBarItem(
      icon: Icon(Ionicons.home_outline,size: APPSTYLE_FontSize24),
      activeIcon: Icon(Ionicons.home,size: APPSTYLE_FontSize24),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Ionicons.calendar_outline,size: APPSTYLE_FontSize24),
      activeIcon: Icon(Ionicons.calendar,size: APPSTYLE_FontSize24),
      label: "",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Ionicons.person_outline,size: APPSTYLE_FontSize24),
      activeIcon: Icon(Ionicons.person,size: APPSTYLE_FontSize24),
      label: "",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // checkNotificationsPermission();
    sharedController.getNotifications();
    profileController.getIngredients();
    profileController.getAllergies();
    tabHistory.add(0);


    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.animateTo(_currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });

  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: _currentIndex==0?APPSTYLE_PrimaryColor:APPSTYLE_BackgroundWhite,
        onDrawerChanged: (isOpened) {
        },
        body: Container(
            padding:
            EdgeInsets.only(top: isConnectivityVisible ? 30.0 : 0.0),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabList,
            )),
        bottomNavigationBar:Container(
            decoration: APPSTYLE_TopShadowedContainerLargeDecoration.copyWith(color: _currentIndex==0?APPSTYLE_PrimaryColor:APPSTYLE_BackgroundOffWhite),
            child: BottomNavigationBar(
                selectedFontSize: 0.0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: APPSTYLE_BackgroundOffWhite,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: APPSTYLE_PrimaryColor,
                unselectedItemColor: APPSTYLE_Grey60,
                onTap: (int index) {
                  tabHistory.add(index);
                  setState(() {
                    _currentIndex = index;
                  });

                  if(index == 0){
                    // final subscriptionsState = BlocProvider.of<SubscriptionsBloc>(context).state;
                    //
                    // context.read<SubscriptionsBloc>().add(
                    //     GetMealsBySubscriptionAndDate(
                    //         date: subscriptionsState.day,
                    //         subscriptionId:
                    //         subscriptionsState.subscriptionId));
                  }

                  _tabController.animateTo(_currentIndex);


                },
                // items:bottomNavigationBarItemsThree
                items: bottomNavigationBarItemsThree
            )
        )
    );

  }

}
