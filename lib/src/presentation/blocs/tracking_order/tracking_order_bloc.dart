import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'tracking_order_event.dart';
part 'tracking_order_state.dart';

class TrackingOrderBloc extends Bloc<TrackingOrderEvent, TrackingOrderState> {
  TrackingOrderBloc({required this.utilityRepository}) : super(TrackingOrderState()) {
    on<TrackingOrderEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetTrackingOrderListFromJson>((event, emit) {
      Order mockOrder = Order.fromJson({
        "orderNo": "1234",
        "shippingStatus": "pending",
        "products": [
          {
            "productId": "PV_EGYJW5CE8Y8G",
            "productNameTh": "Pulsa Max Kook EV 2 Opt 1 Mer1",
            "productNameEn": "Pulsa Max Kook EV 2 Opt 1 Mer1",
            "productDescription": "ทดสอบ",
            "productImageUrl":
                "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_GREY_MONOCHROME_PHONE.png",
            "productQty": 1,
            "price": 59000.0,
            "discountPrice": 40000.0,
            "currency": "Bath",
            "channel": "LINE / GOAPP",
            "createDate": "",
            "lastUpdateDate": "วันที่ update status ของ shipping"
          }
        ],
        "totalPrice": 59000.0,
        "totalQty": 1
      });

      List<Order> mock = [mockOrder, mockOrder];

      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.success, trackingListData: mock));
    });
  }

  final DioUtilityRepository utilityRepository;
}
