import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({required this.utilityRepository}) : super(const ProductDetailState()) {
    on<GetProductByID>(_onGetProduct);
    on<SetProduct>(_onSetProduct);
    on<SetClickFromImage>(_onSetClickFromImage);
  }
  final DioUtilityRepository utilityRepository;

  _onGetProduct(GetProductByID event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(status: ProductDetailStatus.loading));
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();

    try {
      String path = "/ecommerce/v1/products";
      Response response =
          await utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"pid": event.pid}, headers: {"Authorization": "Bearer $accessToken"});
      final p = Product.fromJson(response.data);
      emit(state.copyWith(status: p == Product.empty ? ProductDetailStatus.error : ProductDetailStatus.success, product: p));
    } catch (e) {
      emit(state.copyWith(status: ProductDetailStatus.error));
    }
  }

  _onSetProduct(SetProduct event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(product: event.product, status: ProductDetailStatus.initial));
  }

  _onSetClickFromImage(SetClickFromImage event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(clickFromImage: event.isClickFromImage));
  }
}
