import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

import '../../../model/product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required this.utilityRepository})
      : super(const ProductListState()) {
    on<GetProductList>(_onGetProductList);
    on<GetProductListByCategory>(_onGetProductListByCategory);
    on<GetProductListByPage>(_onGetProductListByPage);
    on<SetSelectTabIndex>(_onSetSelectTabIndex);
  }
  final DioUtilityRepository utilityRepository;

  _onSetSelectTabIndex(
      SetSelectTabIndex event, Emitter<ProductListState> emit) {
    emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
  }

  Future<ProductList> _getProductWithNoCategory() async {
    try {
      LineDataHelper lineDataHelper = LineDataHelper();
      final baseUrl = Environment().getValue("BFF_BASE_URL");
      final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
      String accessToken = await lineDataHelper.getLineAccessToken();
      Response response = await utilityRepository.getByURL(
          "$baseUrl$inventoryApiPath/ecommerce/v1/products", {},
          headers: {"Authorization": "Bearer $accessToken"});
      final productList = ProductList.fromJson(response.data);
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  _onGetProductList(
      GetProductList event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(productListStatus: GetProductListStatus.loading));

    try {
      ProductList productList = await _getProductWithNoCategory();

      if (productList.products!.length == 1 || productList.category!.isEmpty) {
        emit(state.copyWith(hideCategory: true));
      }

      emit(state.copyWith(
          productList: productList,
          productListStatus: GetProductListStatus.success));
    } catch (e) {
      // debugPrint('re-load product list after refresh token');
      try {
        ProductList productList = await _getProductWithNoCategory();

        if (productList.products!.length == 1 ||
            productList.category!.isEmpty) {
          emit(state.copyWith(hideCategory: true));
        }
        emit(state.copyWith(
            productList: productList,
            productListStatus: GetProductListStatus.success));
      } catch (e) {
        emit(state.copyWith(productListStatus: GetProductListStatus.error));
      }
    }
  }

  _onGetProductListByCategory(
      GetProductListByCategory event, Emitter<ProductListState> emit) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    // final nav = Navigator.of(event.context);
    // final Function func = GeneralDialog().showLoadingDialog(context: event.context);
    String accessToken = await lineDataHelper.getLineAccessToken();
    var category = {};

    if (event.categoryId.isNotEmpty) {
      category = {"categoryId": event.categoryId};
    }

    if (event.bypassContext == false) {
      // ignore: use_build_context_synchronously
      GeneralDialog().showLoadingDialog(context: event.context);
    }

    try {
      Response response = await utilityRepository.getByURL(
          "$baseUrl$inventoryApiPath/ecommerce/v1/products", category,
          headers: {"Authorization": "Bearer $accessToken"});

      final productList = ProductList.fromJson(response.data);
      emit(state.copyWith(
          productList: productList,
          productListStatus: GetProductListStatus.success));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    } catch (e) {
      // debugPrint(e.toString());
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    }
  }

  _onGetProductListByPage(
      GetProductListByPage event, Emitter<ProductListState> emit) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    // final Function func = GeneralDialog().showLoadingDialog(context: event.context);
    // final nav = Navigator.of(event.context);
    String accessToken = await lineDataHelper.getLineAccessToken();
    var params = {"page": event.page.toString(), "itemPersPage": 10};

    if (event.categoryId.isNotEmpty) {
      params["categoryId"] = event.categoryId;
    }

    if (event.bypassContext == false) {
      // ignore: use_build_context_synchronously
      GeneralDialog().showLoadingDialog(context: event.context);
    }

    try {
      Response response = await utilityRepository.getByURL(
          "$baseUrl$inventoryApiPath/ecommerce/v1/products", params,
          headers: {"Authorization": "Bearer $accessToken"});

      var currentProductList = ProductList.fromJson(response.data);
      var oldProducts = state.productList.products;

      ProductList nextProduct = ProductList(
          productAllItems: currentProductList.productAllItems,
          productPage: currentProductList.productPage,
          productCountItems: currentProductList.productCountItems,
          banner: currentProductList.banner,
          category: currentProductList.category,
          products: oldProducts! + currentProductList.products!);

      emit(state.copyWith(
          productList: nextProduct,
          productListStatus: GetProductListStatus.success));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    } catch (e) {
      // debugPrint(e.toString());
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    }
  }
}
