import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/resources/language_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  ///Base

  static TextStyle baseStatesMessageTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f16,
      );

  static TextStyle baseStatesElevatedBtnTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Common

  static TextStyle appButtonTextStyle(BuildContext context) => getBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );

  static TextStyle textFieldErrorTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.error.withOpacity(.7),
        fontSize: FontSize.f12,
      );

  static TextStyle optionsMenuOptionTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Splash Screen

  static TextStyle splashScreenTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f60,
      );

  static TextStyle splashScreenSubTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f28,
      );

  ///OnBoarding Screen

  static TextStyle onBoardingScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );

  static TextStyle onBoardingScreenButtonTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Selection Old Screen

  static TextStyle selectionScreenTileTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

  static TextStyle selectionScreenTitleTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f40,
      );

  ///Selection Screen

  static TextStyle selectionScreenButtonTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f18,
      );

  ///Login Screen

  static TextStyle loginScreenTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle loginScreenCountryCodeValueTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenDontHaveAccountTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle loginScreenCreateAccountTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f12,
      );

  static TextStyle loginScreenTextFieldHintTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white.withOpacity(.5),
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenTextFieldValueTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle loginScreenSelectorTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );


  //bus screen
  static TextStyle busItemTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.blue,
        fontSize: FontSize.f18,
      );

  ///Register Screen

  static TextStyle registerScreenTitleTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

  static TextStyle registerScreenAlreadyHaveAccountTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenLoginTextStyle(BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.secondary,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenTextFieldHintTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white.withOpacity(.5),
        fontSize: FontSize.f14,
      );

  static TextStyle registerScreenTextFieldValueTextStyle(
          BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle registerScreenSelectorTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getSecondaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  static TextStyle registerScreenSelectionTitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );
  static TextStyle registerScreenSelectionTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f28,
      );

  static TextStyle registerScreenVerifyDescriptionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white.withOpacity(.4),
        fontSize: FontSize.f12,
      );

  static TextStyle tripMapScreenErrorTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  ///Profile Screen
  static TextStyle profileUserNameTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f20,
      );
  static TextStyle profileSmallTextStyle(BuildContext context, Color color) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f15,
      );
  static TextStyle profileGeneralItemTextStyle(
          BuildContext context, double fontSize) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: fontSize,
      );
  static TextStyle profileGeneralTextStyle(
          BuildContext context, double fontSize, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: fontSize,
      );
  static TextStyle profileHintTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightBlue.withOpacity(.5),
        fontSize: FontSize.f14,
      );
  static TextStyle requestTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.offwhite,
        fontSize: FontSize.f18,
      );

  static TextStyle profileItemTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle profileItemUpdateFieldTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f14,
      );

  static TextStyle profileTripsItemTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f18,
      );

  static TextStyle profileItemUpdateSubFieldTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  ///Buses Screen
  static TextStyle busesTitleTextStyle(BuildContext context) =>
      getExtraBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );
  static TextStyle busesGeneralTextStyle(BuildContext context,Color color, double fontSize) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: fontSize,
      );

  static TextStyle busesItemTextStyle(BuildContext context) => getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightShadeOfBlue.withOpacity(.75),
        fontSize: FontSize.f20,
      );
  static TextStyle busesSubItemTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white.withOpacity(.9),
        fontSize: FontSize.f20,
      );
  static TextStyle busesItemHintTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.75),
        fontSize: FontSize.f12,
      );
  static TextStyle busesItemTripTitleTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.lightBlue.withOpacity(.9),
        fontSize: FontSize.f20,
      );
  static TextStyle busesItemTripTextStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.85),
        fontSize: FontSize.f18,
      );
  static TextStyle busesItemTextBottonStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle busesItemTextSearchStyle(BuildContext context) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f16,
      );

  ///Trip Map Screen

  static TextStyle tripMapScreenMapButtonTextStyle(
          BuildContext context, Color color) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f22,
      );

  static TextStyle tripMapScreenPlaceholderTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.charcoalGrey,
        fontSize: FontSize.f14,
      );

  static TextStyle tripMapScreenFromToTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.mutedBlue,
        fontSize: FontSize.f18,
      );

  static TextStyle tripMapScreenFromToButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.mutedBlue,
        fontSize: FontSize.f18,
      );

  static TextStyle busesItemSearchHintTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white.withOpacity(.75),
        fontSize: FontSize.f16,
      );

  ///Trip Details Screen

  static TextStyle tripScreenVehicleSelectionPageTitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenVehicleSelectionPageItemTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenVehicleSelectionPageButtonTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenConfirmPageTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenConfirmPageVehicleTypeTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenConfirmPageRecommendedFareTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f18,
      );

  static TextStyle tripScreenConfirmPageDescriptionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenConfirmPageButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenPricePageTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.tertiary,
        fontSize: FontSize.f28,
      );

  static TextStyle tripScreenPricePageDescriptionTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f16,
      );

  static TextStyle tripScreenPricePagePlaceholderTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f14,
      );

  static TextStyle tripScreenPricePageButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenSearchPageTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenSearchPageVehicleTypeTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenSearchPagePleaseWaitTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenSearchPageButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenDriverSelectionPageTitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenDriverSelectionPageNameTextStyle(
          BuildContext context, Color color) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f18,
      );

  static TextStyle tripScreenDriverSelectionPageLocationTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  static TextStyle tripScreenDriverSelectionPagePriceTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f12,
      );

  static TextStyle tripScreenDriverSelectionPageCarTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDriverSelectionPageLicenseTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDriverSelectionPageColorTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDriverSelectionPageRateTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDriverSelectionPageTimeTextStyle(
          BuildContext context, Color color) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDriverSelectionPageButtonTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenDetailsPageTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );

  static TextStyle tripScreenDetailsPageNameTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );

  static TextStyle tripScreenDetailsPageLocationTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle tripScreenDetailsPageCarTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDetailsPageLicenseTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDetailsPageColorTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDetailsPageRateTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f10,
      );

  static TextStyle tripScreenDetailsPageButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  /// Rate Screen

  static TextStyle rateScreenTitleTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  static TextStyle rateScreenDescriptionTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  static TextStyle rateScreenButtonTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  /// book trip Search screen

  static TextStyle bookTripSearchScreenTitleTextStyle(BuildContext context) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f24,
      );
  static TextStyle bookTripSearchScreenTitleItemTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.traditional,
        fontSize: FontSize.f24,
      );
  static TextStyle bookTripSearchScreenSubTitleItemTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.grey.withOpacity(.5),
        fontSize: FontSize.f14,
      );
  static TextStyle bookTripSearchScreenButtonItemTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );
  static TextStyle bookTripSearchScreenTitleDialogTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.traditional,
        fontSize: FontSize.f24,
      );

  ///mode screen
  static TextStyle runModeScreenModeTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );
  static TextStyle runModeScreenTurnIntoTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );
  static TextStyle runModeScreenButtonCloseTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );
  static TextStyle runModeScreenTitleContainerTextStyle(BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f12,
      );

  ///waiting searching for passengers
  static TextStyle waitingSearchingForPassengersScreenTitleTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );
  static TextStyle waitingSearchingForPassengersScreenPleaseWaitTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );
  static TextStyle waitingSearchingForPassengersScreenButtonTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );

  ///accepting passengers

  static TextStyle acceptingPassengersScreenPassengerTitleTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f22,
      );
  static TextStyle acceptingPassengersScreenPassengerRateTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.black,
        fontSize: FontSize.f10,
      );
  static TextStyle acceptingPassengersScreenNameTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle acceptingPassengersScreenStartTimeTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle acceptingPassengersScreenCostTextStyle(
          BuildContext context) =>
      getSemiBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle acceptingPassengersScreenTripTimeTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle acceptingPassengersScreenTripDistanceTextStyle(
          BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f18,
      );
  static TextStyle acceptingPassengersScreenButtonTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );
  //running trip
  static TextStyle runningTripScreenTitleTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );
  static TextStyle runningTripScreenButtonTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

//end trip
  static TextStyle endTripScreenTitleTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f22,
      );
  static TextStyle endTripScreenButtonTextStyle(
      BuildContext context) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: ColorManager.white,
        fontSize: FontSize.f20,
      );

}
