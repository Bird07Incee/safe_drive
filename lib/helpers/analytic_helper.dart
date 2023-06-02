// import 'package:flutter/material.dart';
// import 'package:marketplace_line_oa/core/analytic_manager/marketplace_analytic_manager.dart';
// import 'package:marketplace_line_oa/core/marketplace_core.dart';
// import 'package:marketplace_line_oa/models/product_list.dart';
//
// class AnalyticHelper with MarketplaceCoreFeature {
//   MarketplaceAnalyticManager? marketplaceAnalyticManager;
//
//   AnalyticHelper({MarketplaceAnalyticManager? marketplaceAnalyticManager}) {
//     if (marketplaceAnalyticManager != null) {
//       this.marketplaceAnalyticManager = marketplaceAnalyticManager;
//     } else {
//       this.marketplaceAnalyticManager = MarketplaceAnalyticManager.instance;
//     }
//   }
//
//   //Home Screen
//   Future<void> logEnterHomeScreen() async {
//     await marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: 'Usedcar Marketplace Usedcar Homepage View Homepage',
//       screenName: "marketplace_usedcarhomepage",
//       eventName: 'usedcar_marketplace_usedcarhomepage_view_homepage',
//     );
//   }
//
//   Future<void> logClickTopBannerFromHomeScreen(String id, int sequence) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Homepage Click Top Banner",
//         screenName: "marketplace_usedcarhomepage",
//         eventName: "usedcar_marketplace_usedcarhomepage_click_topbanner",
//         params: {
//           "banner_id": id,
//           "banner_sequence": sequence.toString(),
//         });
//   }
//
//   Future<void> logClickSearchbarFromHomeScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Homepage Click Searchbar",
//       screenName: "marketplace_usedcarhomepage",
//       eventName: "usedcar_marketplace_usedcarhomepage_click_searchbar",
//     );
//   }
//
//   Future<void> logClickCarType(String carType) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Homepage Click Car Type",
//         screenName: "marketplace_usedcarhomepage",
//         eventName: "usedcar_marketplace_usedcarhomepage_click_cartype",
//         params: {
//           "cartype_name": carType,
//         });
//   }
//
//   Future<void> logClickCarBrand(String carBrand) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Homepage Click Car Brand",
//         screenName: "marketplace_usedcarhomepage",
//         eventName: "usedcar_marketplace_usedcarhomepage_click_carbrand",
//         params: {
//           "carbrand_name": carBrand,
//         });
//   }
//
//   Future<void> logClickNewPostCarFromHomeScreen(String carId, String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Homepage Click New Post Car ",
//         screenName: "marketplace_usedcarhomepage",
//         eventName: "usedcar_marketplace_usedcarhome_click_newpostcar",
//         params: {
//           "car_id": carId,
//           "partner_name": partnerName,
//         });
//   }
//
//   Future<void> logClickViewAllFromHomeScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Homepage Click View All ",
//       screenName: "marketplace_usedcarhomepage",
//       eventName: "usedcar_marketplace_usedcarhome_click_viewall",
//     );
//   }
//
//   Future<void> logClickBackFromHomeScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Homepage Click Back ",
//       screenName: "marketplace_usedcarhomepage",
//       eventName: "usedcar_marketplace_usedcarhome_click_back",
//     );
//   }
//
// // Search Screen
//   Future<void> logViewSearchScreenFromSearchScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Searchpage View Home ",
//       screenName: "marketplace_usedcarsearchpage",
//       eventName: "usedcar_marketplace_usedcarsearchpage_view_home",
//     );
//   }
//
//   Future<void> logClickCarBrandOnSearchPage(String carBrand) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Searchpage Click Car Brand ",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_carbrand",
//         params: {
//           "carbrand_name": carBrand,
//         });
//   }
//
//   Future<void> logClickCarTypeOnSearchPage(String carType) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Searchpage Click Car Type ",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_cartype",
//         params: {
//           "cartype_name": carType,
//         });
//   }
//
//   Future<void> logClickCarModelOnSearchPage(String carModel) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Searchpage Click Carmodel ",
//         screenName:
//             "marketplace_usedcarsearchpage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_carmodel",
//         params: {
//           "carmodel_name": carModel,
//         });
//   }
//
//   Future<void> logClickRegionOnSearchPage(String region) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Searchpage Click Searchpage Area ",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_searchpage_click_searchpagearea",
//         params: {
//           "area_name": region,
//         });
//   }
//
//   Future<void> logClickBackFromSearchScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Searchpage Click Back",
//       screenName: "marketplace_usedcarsearchpage",
//       eventName: "usedcar_marketplace_searchpage_click_back",
//     );
//   }
//
//   Future<void> logClickSearchBarFromSearchScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Click Marketplace Usedcar Searchpage Searchbar ",
//       screenName: "marketplace_usedcarsearchpage",
//       eventName: "click_marketplace_uc_searchpage_searchbar",
//     );
//   }
//
//   Future<void> logClickSearchBarResultFromCarListScreen(String searchKeyword) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Searchpage Click Searchbar Result ",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_searchbarresult",
//         params: {
//           "search_keyword": searchKeyword,
//         });
//   }
//
//   Future<void> logClickViewAllFromSearchScreen(
//       String carType, String carBrand, String carModel, String areaName, RangeValues priceRange) async {
//     String priceMin = priceRange.start.round().toString();
//     String priceMax = priceRange.end.round().toString();
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Searchpage Click View All ",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_searchpage_click_viewall",
//         params: {
//           "cartype_name": carType,
//           "carbrand_name": carBrand,
//           "carmodel_name": carModel,
//           "area_name": areaName,
//           "price_range": "$priceMin,$priceMax",
//         });
//   }
//
//   Future<void> logClickPriceRangeMin(String priceMin) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace UsedCar SearchPage Click CarPriceMin",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_carpricemin",
//         params: {
//           "carpricemin": priceMin,
//         });
//   }
//
//   Future<void> logClickPriceRangeMax(String priceMax) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace UsedCar SearchPage Click CarPriceMax",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_carpricemax",
//         params: {
//           "carpricemax": priceMax,
//         });
//   }
//
// // Carlist Screen
//   Future<void> logViewCarListScreen(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace View Usedcar Carlist",
//         screenName: "marketplace_usedcarcarlist",
//         eventName: "usedcar_marketplace_view_usedcarcarlist",
//         params: {
//           "partner_name": partnerName,
//         });
//   }
//
//   Future<void> logClickCarPostFromCarListScreen(
//       String carId,
//       String partner,
//       String titleName,
//       String carBrandName,
//       String carModelName,
//       String color,
//       String mileage,
//       String price,
//       String region,
//       String province,
//       String dealerProvince) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar CarList Click Carpost",
//         screenName: "marketplace_usedcarcarlist",
//         eventName: "usedcar_marketplace_usedcarcarlist_click_carpost",
//         params: {
//           "car_id": carId,
//           "partner_name": partner,
//           "title_name": titleName,
//           "carbrand_name": carBrandName,
//           "carmodel_name": carModelName,
//           "color": color,
//           "mileage": mileage,
//           "price": price,
//           "region": region,
//           "province": province,
//           "dealerprovince": dealerProvince
//         });
//   }
//
//   Future<void> logClickBackFromCarListScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Carlist Click Back",
//       screenName: "marketplace_usedcarcarlist",
//       eventName: "usedcar_marketplace_usedcarcarlist_click_back",
//     );
//   }
//
//   Future<void> logClickFilterFromCarListScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Carlist Click Filter",
//       screenName: "marketplace_usedcarcarlist",
//       eventName: "usedcar_marketplace_usedcarcarlist_click_filter",
//     );
//   }
//
// // Filter Dialog Page
//   Future<void> logViewFilterDialogPage() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace View Usedcar Filterpage",
//       screenName: "marketplace_usedcarfilterpage",
//       eventName: "usedcar_marketplace_view_usedcar_filterpage",
//     );
//   }
//
//   Future<void> logClickCarPriceRangeFromFilterDialogPage(String carPriceRange) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Car Price Range",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_carpricerange",
//         params: {
//           "carpricerange_name": carPriceRange,
//         });
//   }
//
//   Future<void> logClickCarYearRangeFromFilterDialogPage(String yearRange) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Car Year Range",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_caryearrange",
//         params: {
//           "caryearrange_name": yearRange,
//         });
//   }
//
//   Future<void> logClickCarMileageRangeFromFilterDialogPage(String mileage) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Car Mileage Range",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_carmileagerange",
//         params: {
//           "carmileagerange_name": mileage,
//         });
//   }
//
//   Future<void> logClickGearTypeFromFilterDialogPage(String gearType) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Gear Type",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_geartype",
//         params: {
//           "geartype_name": gearType,
//         });
//   }
//
//   Future<void> logClickColorFromFilterDialogPage(String color) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Color",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_color",
//         params: {
//           "color_name": color,
//         });
//   }
//
//   Future<void> logClickFuelTypeFromFilterDialogPage(String fuelType) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Fuel Type",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_fueltype",
//         params: {
//           "fueltype_name": fuelType,
//         });
//   }
//
//   Future<void> logClickAreaNameFromFilterDialogPage(String area) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filterpage Click Area",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_area",
//         params: {
//           "area_name": area,
//         });
//   }
//
//   Future<void> logClickResetFromFilterDialogPage() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Filter Page Click Reset",
//       screenName: "marketplace_usedcarfilterpage",
//       eventName: "usedcar_marketplace_usedcar_filterpage_click_reset",
//     );
//   }
//
//   Future<void> logClickCloseFromFilterDialogPage() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Filter Page Click Close",
//       screenName: "marketplace_usedcarfilterpage",
//       eventName: "usedcar_marketplace_usedcar_filterpage_click_close",
//     );
//   }
//
//   Future<void> logClickViewAllFromFilterDialogPage(String gearType, String fuelType, String carPriceRange,
//       String yearRange, String mileage, String area, String color) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Filter Page Click View All",
//         screenName: "marketplace_usedcarfilterpage",
//         eventName: "usedcar_marketplace_usedcar_filterpage_click_viewall",
//         params: {
//           "geartype_name": gearType,
//           "fueltype_name": fuelType,
//           "carpricerange_name": carPriceRange,
//           "caryearrange_name": yearRange,
//           "carmileagerange_name": mileage,
//           "area_name": area,
//           "color_name": color,
//         });
//   }
//
// // Car Detail Screen
//   Future<void> logClickBackFromUsedCarDetail(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Back",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_back",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logEnterUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace View Usedcar Detail",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_view_usedcardetail",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickApplyLoanUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Apply Loan",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_applyloan",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickinspectReportUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Inspection Report",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_inspectionreport",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickViewMapUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click View Map",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_viewmap",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickCallDealerUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Call Dealer",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_calldealer",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickDealerLineUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Dealer Line",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_dealerline",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickLoanBannerUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Loan Banner",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_loanbanner",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickGeneralInfoUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click General Info",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_generalinfo",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickDetailInfoUsedCarDetailScreen(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Detail Info",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_detailinfo",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
//   Future<void> logClickFavoriteCar(ProductData carPostData) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Favorite Button",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_favoritebutton",
//         params: {
//           "partner_name": carPostData.partnerName != null ? carPostData.partnerName! : "",
//           "title_name": carPostData.marketplaceTitle != null ? carPostData.marketplaceTitle! : "",
//           "carbrand_name": carPostData.brand != null ? carPostData.brand! : "",
//           "carmodel_name": carPostData.model != null ? carPostData.model! : "",
//           "car_id": carPostData.contentId != null ? carPostData.contentId! : "",
//           "color": carPostData.color != null && carPostData.color != "" ? carPostData.color! : "",
//           "mileage": carPostData.mileage != null ? carPostData.mileage!.toString() : "",
//           "price": carPostData.price != null ? carPostData.price!.toString() : "",
//           "region": carPostData.registration != null && carPostData.registration != "" ? carPostData.registration! : "",
//           "province": carPostData.registrationProvince != null ? carPostData.registrationProvince! : "",
//           "dealerprovince": carPostData.dealerProvince != null ? carPostData.dealerProvince! : ""
//         });
//   }
//
//   Future<void> logClickCancelFavoriteCar(ProductData carPostData) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Favorite Button Cancel",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_favoritebutton_cancel",
//         params: {
//           "partner_name": carPostData.partnerName != null ? carPostData.partnerName! : "",
//           "title_name": carPostData.marketplaceTitle != null ? carPostData.marketplaceTitle! : "",
//           "carbrand_name": carPostData.brand != null ? carPostData.brand! : "",
//           "carmodel_name": carPostData.model != null ? carPostData.model! : "",
//           "car_id": carPostData.contentId != null ? carPostData.contentId! : ""
//         });
//   }
//
//   Future<void> logClickCalculateLoan(String partner) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Calculate Loan",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_calloan",
//         params: {
//           "partner_name": partner,
//         });
//   }
//
// // Apply Loan Screen
//
//   Future<void> logClickBackFromUsedCarApplyLoanScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Apply Loan Click Back",
//       screenName: "marketplace_usedcarapplyloan",
//       eventName: "usedcar_marketplace_usedcarapplyloan_click_back",
//     );
//   }
//
//   Future<void> logClickPSBannerFromUsedCarApplyLoanScreen(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Apply Loan Click PS Banner",
//       screenName: "marketplace_usedcarapplyloan",
//       eventName: "usedcar_marketplace_usedcarapplyloan_click_psbanner",
//       params: {"partner_name": partnerName},
//     );
//   }
//
//   Future<void> logViewFromUsedCarApplyLoanScreen(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace View Usedcar Apply Loan",
//       screenName: "marketplace_usedcarapplyloan",
//       eventName: "usedcar_marketplace_view_usedcarapplyloan",
//       params: {"partner_name": partnerName},
//     );
//   }
//
//   Future<void> logClickDLDBannerFromUsedCarApplyLoanScreen(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Apply Loan Click DLD Banner",
//       screenName: "marketplace_usedcarapplyloan",
//       eventName: "usedcar_marketplace_usedcarapplyloan_click_dldbanner",
//       params: {"partner_name": partnerName},
//     );
//   }
//
// // Car Inspection Report Screen
//   Future<void> logViewFromUsedCarInspectionReportScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace View Usedcar Inspection Report",
//       screenName: "marketplace_usedcarinspectionreport",
//       eventName: "usedcar_marketplace_view_usedcarinspectionreport",
//     );
//   }
//
//   Future<void> logClickBackFromUsedCarInspectionReportScreen() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Inspection Report Click Back",
//       screenName: "marketplace_usedcarinspectionreport",
//       eventName: "usedcar_marketplace_usedcarinspectionreport_click_back",
//     );
//   }
//
// // Favorite Screen
//   Future<void> logClickMarketplaceUcHomepageFavorite() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Homepage Click Favorite",
//       screenName: "marketplace_usedcarhomepage",
//       eventName: "usedcar_marketplace_usedcarhomepage_click_favorite",
//     );
//   }
//
//   Future<void> logClickMarketplaceUcCarlistFavorite() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Carlist Click Favorite",
//       screenName: "marketplace_usedcarcarlist",
//       eventName: "usedcar_marketplace_usedcarcarlistclick_favorite",
//     );
//   }
//
// // 181
//   Future<void> logClickMarketplaceViewFavoritePage({String? carId}) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Marketplace View Favorite Page",
//         screenName: "marketplace_favoritepage",
//         eventName: "marketplace_view_favoritepage",
//         params: {"car_id": carId!});
//   }
//
//   Future<void> logClickMarketplaceClickFavoritePageCancel(
//       {String? carId, String? partnerName, String? titleName, String? carBrandName, String? carModelName}) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "UsedCar Marketplace Favorite Page Click Favorite Button Cancel",
//         screenName: "marketplace_favoritepage",
//         eventName: "usedcar_marketplace_favoritepage_click_favoritebutton_cancel",
//         params: {
//           "car_id": carId!,
//           "partner_name": partnerName!,
//           "title_name": titleName!,
//           "carbrand_name": carBrandName!,
//           "carmodel_name": carModelName!
//         });
//   }
//
//   Future<void> logClickMarketplaceFavoritePageCarPost({
//     String? carId,
//     String? partnerName,
//     String? titleName,
//     String? carBrandName,
//     String? carModelName,
//     String? color,
//     String? mileage,
//     String? price,
//     String? region,
//     String? province,
//     String? dealerProvince,
//   }) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Marketplace Favorite Page Click CarPost",
//         screenName: "marketplace_favoritepage",
//         eventName: "marketplace_favoritepage_click_carpost",
//         params: {
//           "car_id": carId!,
//           "partner_name": partnerName!,
//           "title_name": titleName!,
//           "carbrand_name": carBrandName!,
//           "carmodel_name": carModelName!,
//           "color": color!,
//           "mileage": mileage!,
//           "price": price!,
//           "region": region!,
//           "province": province!,
//           "dealerprovince": dealerProvince!,
//         });
//   }
//
//   Future<void> logClickMarketplaceFavoritePageBack() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Marketplace Favorite Page Click Back",
//       screenName: "marketplace_favoritepage",
//       eventName: "marketplace_favoritepage_click_back",
//     );
//   }
//
//   //29
//   Future<void> logClickCalculator(String? partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Detail Click Cal Loan",
//         screenName: "marketplace_usedcardetail",
//         eventName: "usedcar_marketplace_usedcardetail_click_calloan",
//         params: {"partner_name": partnerName!});
//   }
//
//   Future<void> logViewMarketplaceUsedCarCalculator(String? partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace View Usedcar Calculator",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_view_usedcarcalculator",
//         params: {"partner_name": partnerName!});
//   }
//
//   Future<void> logClickMarketplaceUsedCarCalculatorBack() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Calculator Click Back",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_usedcarcalculator_click_back");
//   }
//
//   Future<void> logClickMarketplaceUsedCarCalculatorChangedDownPayment(String? downPercentage, String? downBath) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Calculator Click Changed DownPayment",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_usedcarcalculator_click_changeddownpayment",
//         params: {"down_percentage": downPercentage!, "down_baht": downBath!});
//   }
//
//   Future<void> logClickMarketplaceUsedCarCalculatorChangedTerm(String? monthInstallment) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Calculator Click Changed TermLoan",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_usedcarcalculator_click_changedtermloan",
//         params: {"month_installment": monthInstallment!});
//   }
//
//   Future<void> logUsedCarMarketplaceUsedCarCalculatorClickPSBanner(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Calculator Click PSBanner",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_usedcarcalculator_click_psbanner",
//         params: {"partner_name": partnerName});
//   }
//
//   Future<void> logClickMarketplaceUsedCarCalculatorDLDBanner(String partnerName) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Calculator Click DLDBanner",
//         screenName: "marketplace_usedcarcalculator",
//         eventName: "usedcar_marketplace_usedcarcalculator_click_dldbanner",
//         params: {"partner_name": partnerName});
//   }
//
//   Future<void> logClickMarketplaceUsedCarOrderbyPageSort(String sortType) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Sortby Click Sortby",
//         screenName: "marketplace_usedcarsortby",
//         eventName: "usedcar_marketplace_usedcarsortby_click_sortby",
//         params: {"sort_type": sortType});
//   }
//
//   Future<void> logClickMarketplaceUsedCarOrderbyPageSortClose() async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//       eventType: "Usedcar Marketplace Usedcar Sortby Click Close",
//       screenName: "marketplace_usedcarsortby",
//       eventName: "usedcar_marketplace_usedcarsortby_click_close",
//     );
//   }
//
//   Future<void> logClickViewMarketplaceUcSearchPage(String umId, String userLevel) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Search Page View Home",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_view_home",
//         params: {'umId': umId, 'userlevel': userLevel});
//   }
//
//   Future<void> logClickMarketplaceUcSearchpageFilterHistory(
//       Map<String, dynamic> data, String umId, String userLevel) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Usedcar Search Page Click Filter History",
//         screenName: "marketplace_usedcarsearchpage",
//         eventName: "usedcar_marketplace_usedcarsearchpage_click_filter_history",
//         params: {
//           'cartype_name': data['type'] ?? '',
//           'carbrand_name': data['brand'] ?? '',
//           'carmodel_name': data['model'] ?? '',
//           'carprice': (data['price'] ?? '0-0').split('-').join(','),
//           'area_name': data['region'] ?? '',
//           'umId': umId,
//           'userlevel': userLevel
//         });
//   }
//
//   Future<void> logURL(String url) async {
//     marketplaceAnalyticManager?.logActivityAndEvent(
//         eventType: "Usedcar Marketplace Log Url",
//         screenName: "marketplace_logurl",
//         eventName: "usedcar_marketplace_log_url",
//         params: {"url": url});
//   }
// }
