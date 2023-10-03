import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(const ProductDetailState()) {
    on<GetProductByID>(_onGetProduct);
  }


  _onGetProduct(GetProductByID event, Emitter<ProductDetailState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = lineDataHelper.getLineAccessToken();

    emit(state.copyWith(status: ProductDetailStatus.loading));

    try {
      String path = "/ecommerce/v1/products${event.pid != '' ? '?pid=${event.pid}' : ''}";
      Response response = await dioUtilityRepository.postByURL("$baseUrl$inventoryApiPath$path", {},
          headers: {"Authorization": "Bearer $accessToken"});

      final p = Product.fromJson(response.data);
      emit(state.copyWith(status: ProductDetailStatus.success, product: p));
    } catch (e) {
      emit(state.copyWith(status: ProductDetailStatus.error));
    }
  }
}