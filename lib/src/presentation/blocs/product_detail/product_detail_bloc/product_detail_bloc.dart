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
  ProductDetailBloc({required this.utilityRepository})
      : super(const ProductDetailState()) {
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
      Response response = await utilityRepository.getByURL(
          "$baseUrl$inventoryApiPath$path", {"pid": event.pid},
          headers: {"Authorization": "Bearer $accessToken"});
      response.data["remark"] = <String>[];
      final p = Product.fromJson(response.data);
      Product productMock = Product(
          appId: p.appId,
          merchantId: p.merchantId,
          paymentChannelCode: p.paymentChannelCode,
          refundDay: p.refundDay,
          postDate: p.postDate,
          lastUpdateDate: p.lastUpdateDate,
          categoryId: p.categoryId,
          productId: p.productId,
          quantity: p.quantity,
          productName: p.productName,
          productStatus: p.productStatus,
          commissionAmount: p.commissionAmount,
          serviceFee: p.serviceFee,
          shippingFee: p.shippingFee,
          tagline: p.tagline,
          promotionTag: p.promotionTag,
          description: p.description,
          technicalSpec: p.technicalSpec,
          remark: const ["•  ข้อมูลนี้เป็นข้อมูลจากผู้ขาย อาจมีการเปลี่ยนแปลงได้ตลอดเวลา",
            "•  กรุงศรี ออโต้ Line Official Account เป็นช่องทางการแสดงสินค้าเท่านั้น",
            "•  สอบถามข้อมูลเพิ่มเติมเกี่ยวกับสินค้า กรุณาติดต่อผู้ขาย merchantFullName ที่หมายเลข 091-862-5011",
            "•  แจ้งปัญหาการสั่งซื้อสินค้า กรุณาติดต่อผู้ดูแลระบบที่หมายเลข 02-023-8858"],
          currency: p.currency,
          price: p.price,
          discountPrice: p.discountPrice,
          percentDiscountPrice: p.percentDiscountPrice,
          productionAssets: p.productionAssets,
          merchantFullName: p.merchantFullName,
          merchantAddress: p.merchantAddress,
          merchantLogo: p.merchantLogo,
          merchantMobile: p.merchantMobile,
          merchantEmail: p.merchantEmail,
          productionOptionals: p.productionOptionals);

      emit(state.copyWith(
          status: productMock == Product.empty  //p
              ? ProductDetailStatus.error
              : ProductDetailStatus.success,
          product: productMock));
    } catch (e) {
      emit(state.copyWith(status: ProductDetailStatus.error));
    }
  }

  _onSetProduct(SetProduct event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(
        product: event.product, status: ProductDetailStatus.initial));
  }

  _onSetClickFromImage(
      SetClickFromImage event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(clickFromImage: event.isClickFromImage));
  }
}
