import 'package:dietsteps/feature_modules/my_subscription/models/subscription_dailymeal.model.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_dailymeal_item.model.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_date.model.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/models/subscription_mealconfig.model.my_subscription.dart';
import 'package:dietsteps/feature_modules/my_subscription/services/http.my_subscription.service.dart';
import 'package:dietsteps/shared_module/constants/app_route_names.constants.shared.dart';
import 'package:dietsteps/shared_module/constants/valid_subscription_day_status.constants.shared.dart';
import 'package:dietsteps/shared_module/controllers/controller.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/date_conversion.service.shared.dart';
import 'package:dietsteps/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySubscriptionController extends GetxController {

  var isSubscriptionDatesLoading = false.obs;
  var subscriptionDates = <SubscriptoinDate>[].obs;
  var currentMonth = DateTime (DateTime.now().year,DateTime.now().month,1).obs;
  var subscriptionMonths = <DateTime>[].obs;
  var subscriptionDays = <DateTime>[].obs;
  var firstWeekDays = <DateTime>[].obs;
  var secondWeekDays = <DateTime>[].obs;
  var thirdWeekDays = <DateTime>[].obs;
  var fourthWeekDays = <DateTime>[].obs;
  var fifthWeekDays = <DateTime>[].obs;
  var sixthWeekDays = <DateTime>[].obs;
  // var frozenDays = <String>[].obs;
  var isDayMealSaving = false.obs;
  var isFreezing = false.obs;
  var isMealsFetching = false.obs;
  var recommendedCalories = (0.0).obs;
  var selectedDate = DateTime.now().obs;
  var subscriptoinMealConfig = mapSubscriptoinMealConfig({}, "").obs ;
  var selectedMealConfig = mapSubscriptoinMealConfig({}, "").obs ;
  var itemScrollController = ItemScrollController();
  var isRatingSubmitting = false.obs;
  var currentSelectedRating = (1).obs;


  getSubscriptionDates(bool setDate, bool getSubs) async {
    if(!isSubscriptionDatesLoading.value){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? tMobile = prefs.getString('mobile');
      if (tMobile != null && tMobile != '') {
        isSubscriptionDatesLoading.value = true;

        var mySubsHttpService = MySubsHttpService();
        subscriptionDates.value = await mySubsHttpService.getSubscriptionDates(tMobile);
        isSubscriptionDatesLoading.value = false;
        isFreezing.value = false;
        setCurrentMonth();
        if(setDate){
          setSelectedDate();
        }
        if(getSubs){
          getMealsByDate(selectedDate.value,false);
        }
        // frozenDays.value = [];
      } else {
        isFreezing.value = false;
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }

    }else{
      isFreezing.value = false;
    }
  }

  // isAlreadySelectedForFreezing(DateTime dateTime){
  //   final f = DateFormat('yyyy-MM-dd');
  //   return frozenDays.contains(f.format(dateTime));
  // }

  // addDayToFreeze(DateTime dateTime){
  //   if(dateTime.month== currentMonth.value.month && isSubscriptionDay(dateTime)
  //      && dateTime.isAfter(DateTime.now())
  //       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.delivered
  //       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.offDay
  //       && getDayStatus(dateTime) != VALIDSUBSCRIPTIONDAY_STATUS.freezed){
  //     final f = DateFormat('yyyy-MM-dd');
  //     if(frozenDays.contains(f.format(dateTime)) ){
  //       frozenDays.remove(f.format(dateTime));
  //     }else{
  //       frozenDays.add(f.format(dateTime));
  //     }
  //   }
  //
  // }

  void setSelectedDate() {

    if(subscriptionDates.isNotEmpty) {
      DateTime startDate = subscriptionDates.first.date;
      selectedDate.value = startDate.isAfter(DateTime.now())?
      startDate:DateTime.now();
    }

  }

  void setCurrentMonth() {

    if(subscriptionDates.isNotEmpty){

      DateTime startDate = subscriptionDates.first.date;
      DateTime endDate = subscriptionDates.last.date;

      currentMonth.value = getCurrentMonth(startDate, endDate);

      subscriptionDates.forEach((element) {
        subscriptionDays.add(element.date);

        if(!doesContainDate(subscriptionMonths,DateTime(element.date.year,element.date.month,1))){
          subscriptionMonths.add(DateTime(element.date.year,element.date.month,1));
        }
      });
      setCurrentMonthWeekDays();
    }

  }

  void previousMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month - 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();
  }

  void nextMonth() {
    var newDate = DateTime(currentMonth.value.year, currentMonth.value.month + 1, currentMonth.value.day);
    currentMonth.value = newDate;
    setCurrentMonthWeekDays();
  }

  doesContainDate(List<DateTime> dateLists ,DateTime fourthWeekDay){
    bool doesContain = false;
    for(var i=0; i<dateLists.length; i++){
      if(fourthWeekDay.year == dateLists[i].year &&
          fourthWeekDay.month == dateLists[i].month &&
          fourthWeekDay.day == dateLists[i].day ){
        doesContain = true;
      }
    }
    return doesContain;
  }

  DateTime getCurrentMonth(DateTime startDate, DateTime toDate) {
    if (startDate.month == toDate.month) {
      return DateTime(startDate.year, startDate.month, 1);
    } else {
      if (DateTime.now().isBefore(startDate)) {
        return DateTime(startDate.year, startDate.month, 1);
      } else if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(toDate)) {
        return DateTime(DateTime.now().year, DateTime.now().month, 1);
      } else {
        return DateTime(toDate.year, toDate.month, 1);
      }
    }
  }

  bool isSubscriptionDay(DateTime firstWeekDay) {
    return subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList().isNotEmpty;
  }
  int  getDaySubId(DateTime firstWeekDay) {

    print("getDaySubId");
    print(firstWeekDay);
    print(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList());
    if(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList().isEmpty){
      return -1;
    }
    print(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList()[0].subscriptionId.toString());
    print(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList()[0].date.toString());
    print(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList()[0].status.toString());
    return subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList()[0].subscriptionId;
  }
  String  getDayStatus(DateTime firstWeekDay) {

    if(subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList().isEmpty){
      return "";
    }

    return subscriptionDates.where((p0) => isSameDay(p0.date,firstWeekDay)).toList()[0].status;
  }
  setCurrentMonthWeekDays() {

    List<DateTime> weekDays = [];
    DateTime weekStartDate = getDate(currentMonth.value.subtract(Duration(days: currentMonth.value.weekday))) ;
    DateTime weekEndDate = getDate(currentMonth.value.add(Duration(days: DateTime.daysPerWeek - (currentMonth.value.weekday+1))));
    print("weekStartDate month: ${weekStartDate.month}");
    print("weekEndDate month: ${weekEndDate.month}");
    print("currentMonth.value month : ${currentMonth.value.month}");
    if(weekStartDate.month < currentMonth.value.month && weekEndDate.month < currentMonth.value.month){
      weekStartDate = currentMonth.value;
      weekEndDate = currentMonth.value.add(Duration(days: 6));
    }
    print("weekStartDate : $weekStartDate");
    print("weekEndDate : $weekEndDate");
    firstWeekDays.clear();
    secondWeekDays.clear();
    thirdWeekDays.clear();
    fourthWeekDays.clear();
    fifthWeekDays.clear();
    sixthWeekDays.clear();
    for (int index = 1; index <= 6; index++) {
      weekDays=[];
      if (index != 1) {
        weekStartDate = weekStartDate.add(Duration(days:   7));
        weekEndDate = weekEndDate.add(Duration(days:   7));
      }

      for (int i = 0; i <= weekEndDate
          .difference(weekStartDate)
          .inDays; i++) {
        weekDays.add(weekStartDate.add(Duration(days: i)));
      }

      switch (index){
        case 1:{
          firstWeekDays.addAll(weekDays);
          break;
        }
        case 2:
          {
            secondWeekDays.addAll(weekDays);
            break;
          }
        case 3:
          {
            thirdWeekDays.addAll(weekDays);
            break;
          }
        case 4:
          {
            fourthWeekDays.addAll(weekDays);
            break;
          }
        case 5:
          {
            fifthWeekDays.addAll(weekDays);
            break;
          }
        case 6:
          {
            sixthWeekDays.addAll(weekDays);
            break;
          }
      }

    }

  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> getMealsByDate(  DateTime tSelectedDay,bool isNavigationRequired ) async {
    if(isSubscriptionDay(tSelectedDay)){
      selectedDate.value = tSelectedDay;

      if( getDayStatus(tSelectedDay) != VALIDSUBSCRIPTIONDAY_STATUS.offDay

          && !isMealsFetching.value){


        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? tMobile = prefs.getString('mobile');
        if (tMobile != null && tMobile != '') {
          isMealsFetching.value = true;
          if(isNavigationRequired){
            Get.toNamed(AppRouteNames.mealSelectionRoute);
          }
          final f = new DateFormat('yyyy-MM-dd');

          var mySubsHttpService = MySubsHttpService();
          subscriptoinMealConfig.value =  await mySubsHttpService.getMealsByDay(tMobile,f.format(selectedDate.value));

          initializeMealSelection(f.format(selectedDate.value));
          isMealsFetching.value = false;

        } else {
          showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
          showSnackbar(Get.context!, "login_message".tr, "error");
          Get.offAllNamed(AppRouteNames.loginRoute);
        }

      }else{
        subscriptoinMealConfig.value = mapSubscriptoinMealConfig({},  "");
        selectedMealConfig.value = mapSubscriptoinMealConfig({},  "");
        Get.toNamed(AppRouteNames.mealSelectionRoute);
      }
    }

  }


  bool isSetMealsEnabled(bool isNavigateBack,bool isFromBackbutton){

    if(isDayMealSaving.value || isFreezing.value){
      return false;
    }

    if(getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.offDay  || getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.delivered){
      return false;
    }

    if(getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.mealNotSelected &&
        selectedMealConfig.value.meals.where((element) => element.items.isNotEmpty).toList().isEmpty){
      showSnackbar(Get.context!, "please_select_meals_for_all_categories".tr, "error");
      return false;
    }


    if(getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.mealSelected &&
        selectedMealConfig.value.meals.where((element) => element.items.length==element.itemCount).toList().length
            !=selectedMealConfig.value.meals.length && isNavigateBack){
      showSnackbar(Get.context!, "please_select_meals_for_all_categories".tr, "error");
      return false;
    }

    if(getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.freezed && isFromBackbutton){
      return false;
    }

    if(getDayStatus(selectedDate.value) ==
        VALIDSUBSCRIPTIONDAY_STATUS.freezed && selectedMealConfig.value.meals.where((element) => element.items.length==element.itemCount).toList().length
        !=selectedMealConfig.value.meals.length){
      return false;
    }

    return true;

  }


  Future<void> setMealsByDate(bool isNavigateBack,int subscriptionId,bool isFromBackbutton ) async {
    print("setMealsByDate");
    print(isSetMealsEnabled(isNavigateBack,isFromBackbutton));
    if(isSetMealsEnabled(isNavigateBack,isFromBackbutton)){
      if(getDayStatus(selectedDate.value) ==
          VALIDSUBSCRIPTIONDAY_STATUS.freezed &&
          selectedMealConfig.value.meals.where((element) => element.items.length==element.itemCount).toList().length
              ==selectedMealConfig.value.meals.length && !isFromBackbutton){
        unfreezeAndSaveMeals();
      }else{
        print("else reached");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? tMobile = prefs.getString('mobile');
        if (tMobile != null && tMobile != '') {

          if(subscriptionId != -1){
            isDayMealSaving.value = true;
            final f = new DateFormat('yyyy-MM-dd');
            var mySubsHttpService = MySubsHttpService();
            bool isSuccess  =  await mySubsHttpService.saveMealsByDay(subscriptionId,selectedMealConfig.value, f.format(selectedDate.value));

            if(isSuccess){
              if(isNavigateBack){
                Get.back();
                showSnackbar(Get.context!, "selection_saved".tr, "info");
              }

              getSubscriptionDates(false,false);

            }

            isDayMealSaving.value = false;
          }else {
            showSnackbar(Get.context!, "no_subscription".tr, "error");
          }

        } else {
          showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
          showSnackbar(Get.context!, "login_message".tr, "error");
          Get.offAllNamed(AppRouteNames.loginRoute);
        }

      }

    }


  }



  void initializeMealSelection(String date) {
    print("initializeMealSelection data recieved");
    print(subscriptoinMealConfig.value.recommendedCalories);
    print(subscriptoinMealConfig.value.meals.length);
    print(subscriptoinMealConfig.value.meals[0].items.length);
    try{
      List<SubscriptoinDailyMeal> meals = [];
      double recommendedCalories = 0.0;
      for (var element in subscriptoinMealConfig.value.meals) {

        List<SubscriptoinDailyMealItem> mealItems = [];

        for (var item in element.items) {
          if(item.selectedCount>0){
            for(var i=0;i<item.selectedCount;i++){
              recommendedCalories += item.calories;
              mealItems.add(item);
            }

          }
        }
        print("initializeMealSelection data recieved");
        print(mealItems.length);
        print(element.itemCount);
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            arabicName: element.arabicName,
            items: mealItems,
            itemCount: element.itemCount,
            isAlreadySelected: element.itemCount==mealItems.length
        ));
      }
      selectedMealConfig.value = SubscriptoinMealConfig(date: date,
          recommendedCalories:recommendedCalories,
          meals: meals);

    }catch (e,st){
      print(e);
      print(st);
      print("reached error");
    }

  }

  addOrRemoveMeal(int index, int categoryId, int mealId, int count){
    double currentSelectedCalories = selectedMealConfig.value.recommendedCalories;
    List<SubscriptoinDailyMeal> meals = [];
    for (var element in subscriptoinMealConfig.value.meals) {
      if(element.id != categoryId){
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            arabicName: element.arabicName,
            isAlreadySelected: element.isAlreadySelected,
            items: getAlreadySelectedMeals(element.id),
            itemCount: element.itemCount));
      }else{
        List<SubscriptoinDailyMealItem> mealItem = element.items.where((element) => element.id==mealId).toList();
        if(mealItem.isEmpty){
          meals.add(SubscriptoinDailyMeal(
              name: element.name,
              id: element.id,
              isAlreadySelected: element.isAlreadySelected,
              arabicName: element.arabicName,
              items: getAlreadySelectedMeals(element.id),
              itemCount: element.itemCount));
        }else{
          if(count<0){

            List<SubscriptoinDailyMealItem> alreadySelectedMeals = getAlreadySelectedMeals(element.id);
            final item = alreadySelectedMeals.firstWhere((e) => element.id !=mealId);
            alreadySelectedMeals.remove(item);
            meals.add(SubscriptoinDailyMeal(
                name: element.name,
                id: element.id,
                isAlreadySelected: element.isAlreadySelected,
                arabicName: element.arabicName,
                items: alreadySelectedMeals,
                itemCount: element.itemCount));
            currentSelectedCalories -= mealItem[0].calories;
            removeSelectionPerCategoryAll(categoryId);
          }else{
            if(isMealMaximumCountReached(element.id)){
              showSnackbar(Get.context!, "meal_limit_reached".tr, "error");
              meals.add(SubscriptoinDailyMeal(
                  name: element.name,
                  id: element.id,
                  isAlreadySelected: element.isAlreadySelected,
                  arabicName: element.arabicName,
                  items: getAlreadySelectedMeals(element.id),
                  itemCount: element.itemCount));
            }else{
              List<SubscriptoinDailyMealItem> mealItemsToAdd = [];
              mealItemsToAdd.add(mealItem[0]);
              mealItemsToAdd.addAll(getAlreadySelectedMeals(element.id));
              meals.add(SubscriptoinDailyMeal(
                  name: element.name,
                  id: element.id,
                  isAlreadySelected: element.isAlreadySelected,
                  arabicName: element.arabicName,
                  items: mealItemsToAdd,
                  itemCount: element.itemCount));
              currentSelectedCalories += mealItem[0].calories;
            }

          }

        }
      }
    }
    selectedMealConfig.value = SubscriptoinMealConfig(
        date: selectedMealConfig.value.date,
        recommendedCalories:currentSelectedCalories, meals: meals);

    if(selectedMealConfig.value.meals.length> (index+1) &&  isMealMaximumCountReached(categoryId)) {
      itemScrollController.scrollTo(index: index+1, duration: Duration(milliseconds: 500));
    }

  }

  List<SubscriptoinDailyMealItem> getAlreadySelectedMeals(int categoryId ){
    if(selectedMealConfig.value.meals.where((element) => element.id==categoryId ).toList().isNotEmpty){
      return selectedMealConfig.value.meals.where((element) => element.id==categoryId
      ).toList()[0].items;
    }else{
      return [];
    }
  }

  getMealSelectedCount(int categoryId, int mealId){

    final List<SubscriptoinDailyMeal> meals = selectedMealConfig.value.meals.where((element) => element.id==categoryId).toList();

    if(meals.isEmpty){
      return 0;
    }
    return meals[0].items.where((element) => element.id==mealId).toList().length;
  }

  isMealMaximumCountReached(int categoryId){

    List<SubscriptoinDailyMeal> originalMeals = [];
    List<SubscriptoinDailyMeal> selectedMeals = [];

    selectedMeals =  selectedMealConfig.value.meals.where((element) => element.id==categoryId ).toList();
    originalMeals =  subscriptoinMealConfig.value.meals.where((element) => element.id==categoryId ).toList();

    if(selectedMeals.isNotEmpty && originalMeals.isNotEmpty){
      return selectedMeals[0].items.length==originalMeals[0].itemCount;
    }
    return true;

  }

  Future<void> freezeSubscription(DateTime dateTime, bool isFreeze) async {
    if(!isFreezing.value){
      int subscriptionId = getDaySubId(dateTime);
      if(subscriptionId != -1){
        final f = DateFormat('yyyy-MM-dd');
        List<String> frozenDays = [];
        frozenDays.add(f.format(dateTime));
        isFreezing.value = true;
        var mySubsHttpService = MySubsHttpService();
        bool isSuccess  =  await mySubsHttpService.freezeSubscriptionDays(subscriptionId,frozenDays,isFreeze);
        if(isSuccess){
          Get.back();
          if(isFreeze){
            showSnackbar(Get.context!, "subscription_frozen".tr, "info");
          }else{
            showSnackbar(Get.context!, "subscription_unfrozen".tr, "info");
          }
          getSubscriptionDates(false, false);
        }else{
          isFreezing.value = false;
        }


      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }



    }


  }


  removeSelectionPerCategory(int categoryId, ){
    double currentSelectedCalories = selectedMealConfig.value.recommendedCalories;
    List<SubscriptoinDailyMeal> meals = [];
    for (var element in selectedMealConfig.value.meals) {
      if(element.id != categoryId){
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            isAlreadySelected: element.isAlreadySelected,

            arabicName: element.arabicName,
            items: getAlreadySelectedMeals(element.id),
            itemCount: element.itemCount));
      }else{
        for (var el in element.items) {
          currentSelectedCalories -= el.calories;
        }
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            isAlreadySelected: false,
            arabicName: element.arabicName,
            items: [],
            itemCount: element.itemCount));
      }
    }
    selectedMealConfig.value = SubscriptoinMealConfig(
        date: selectedMealConfig.value.date,
        recommendedCalories:currentSelectedCalories, meals: meals);
    removeSelectionPerCategoryAll(categoryId);
  }
  removeSelectionPerCategoryAll(int categoryId, ){
    double currentSelectedCalories = subscriptoinMealConfig.value.recommendedCalories;
    List<SubscriptoinDailyMeal> meals = [];
    for (var element in subscriptoinMealConfig.value.meals) {
      if(element.id != categoryId){
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            isAlreadySelected: element.isAlreadySelected,
            arabicName: element.arabicName,
            items: element.items,
            itemCount: element.itemCount));
      }else{
        meals.add(SubscriptoinDailyMeal(
            name: element.name,
            id: element.id,
            isAlreadySelected: false,
            arabicName: element.arabicName,
            items:element.items,
            itemCount: element.itemCount));
      }
    }
    subscriptoinMealConfig.value = SubscriptoinMealConfig(
        date: subscriptoinMealConfig.value.date,
        recommendedCalories:subscriptoinMealConfig.value.recommendedCalories, meals: meals);

  }

  Future<void> unfreezeAndSaveMeals() async {
    if(!isFreezing.value){
      int subscriptionId =  getDaySubId(selectedDate.value);
      if(subscriptionId != -1){
        final f = DateFormat('yyyy-MM-dd');
        List<String> frozenDays = [];
        frozenDays.add(f.format(selectedDate.value));
        isFreezing.value = true;
        var mySubsHttpService = MySubsHttpService();
        bool isSuccess  =  await mySubsHttpService.freezeSubscriptionDays(subscriptionId,frozenDays,false);
        if(isSuccess){
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final String? tMobile = prefs.getString('mobile');
          if (tMobile != null && tMobile != '') {

            int subscriptionId =  getDaySubId(selectedDate.value);

            if(subscriptionId != -1){
              isDayMealSaving.value = true;
              final f = new DateFormat('yyyy-MM-dd');
              var mySubsHttpService = MySubsHttpService();
              bool isSuccess  =  await mySubsHttpService.saveMealsByDay(subscriptionId,selectedMealConfig.value, f.format(selectedDate.value));
              isFreezing.value = false;

              if(isSuccess){
                Get.back();
                showSnackbar(Get.context!, "selection_saved".tr, "info");
                getSubscriptionDates(false,false);
              }

              isDayMealSaving.value = false;
            }else {
              showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
              showSnackbar(Get.context!, "login_message".tr, "error");
              Get.offAllNamed(AppRouteNames.loginRoute);
            }

          } else {
            showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
            showSnackbar(Get.context!, "login_message".tr, "error");
            Get.offAllNamed(AppRouteNames.loginRoute);
          }

        }else{
          isFreezing.value = false;
        }


      }else {
        showSnackbar(Get.context!, "couldnt_load_profiledata".tr, "error");
        showSnackbar(Get.context!, "login_message".tr, "error");
        Get.offAllNamed(AppRouteNames.loginRoute);
      }



    }
  }


  changeSelectedRating(int rating){
    currentSelectedRating.value = rating;
  }

  Future<void> rateMeal(int mealId) async {
    final sharedController = Get.find<SharedController>();

    if(sharedController.userData.value.id !=-1){
      isRatingSubmitting.value = true;
      var mySubsHttpService = MySubsHttpService();
      bool isSuccess = await mySubsHttpService.rateMeals(
          sharedController.userData.value.mobile,
          mealId, currentSelectedRating.value);
      getSubscriptionDates(false, true);
      currentSelectedRating.value =1;
      isRatingSubmitting.value = false;

      Get.back();
      if(isSuccess){
        showSnackbar(Get.context!, "rating_saved".tr, "info");
      }
    }

  }
}