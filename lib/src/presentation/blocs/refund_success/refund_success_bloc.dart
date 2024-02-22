import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/refund_success_data_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_event.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_state.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

class RefundSuccessBloc extends Bloc<RefundSuccessEvent, RefundSuccessState> {
  RefundSuccessBloc({required this.utilityRepository}) : super(RefundSuccessState()) {
    on<GetRefundSuccess>(_onGetRefundSuccess);
  }

  final DioUtilityRepository utilityRepository;

  _onGetRefundSuccess(GetRefundSuccess event, Emitter<RefundSuccessState> emit) async {
    emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.loading));
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    final refundPath = Environment().getValue("REFUND_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.invoiceNo, "uid": uid};
    try {
      // Response response =
      //     await utilityRepository.postByURL("$baseUrl$transactionApiPath$refundPath", payload, headers: {"Authorization": "Bearer $accessToken"});

      var mock = {
        "status": "Complete",
        "refundInfo": {
          "refundNo": "RFLA20240215100358LXVdT",
          "refundDate": "21 กุมภาพันธ์ 2567",
          "refundTime": "18:32:17",
          "reason": "test reason ipp",
          "remark": "test remark ipp"
        },
        "rawData": {
          "invoiceNo": "LA20240215100138ZKR6H",
          "cardNo": "XXXXXXXXXXXX0006",
          "paymentDate": "15 กุมภาพันธ์ 2567",
          "paymentTime": "10:03:20",
          "paymentGateway": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)",
          "paymentChannel": "IPP",
          "amount": "47,890",
          "merchantFullName": "ChocoCard Store",
          "merchantAddress": "2150/4  ถนนสุขุมวิท บางจาก พระโขนง กรุงเทพมหานคร 10260",
          "merchantMobile": "0123456789",
          "productImagePath":
              "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20231225_035156_Privilege_XK099RS.png?sv=2020-08-04&se=2028-11-28T08%3A51%3A56Z&sr=b&sp=r&sig=1aVZGa3bm5eiP5sU9mwhgw5z5Vb7XBWxwz%2BO6i%2Flghs%3D",
          "productId": "PV_2Q3HC9TC7ONG",
          "productOption": " Kook EV 2 Opt 3 Mer1 สายสีน้ำเงิน",
          "productName": "Pulsa Max Kook EV 2 Opt 1 Mer1 ",
          "customerFullname": "sss",
          "customerMobile": "0810155211",
          "customerEmail": "atirat.chunsith@gmail.com",
          "customerAddress": "23  คันนายาว คันนายาว กรุงเทพมหานคร 10230",
          "installmentPeriod": "10",
          "paymentChannelText": "ผ่อนชำระ 10 เดือน "
        }
      };
      Map<String, dynamic> refundJsonData = {"status": mock["status"]};
      // refundJsonData.addAll(response.data["refundInfo"]);
      // refundJsonData.addAll(response.data["rawData"]);
      refundJsonData.addAll(mock["refundInfo"] as Map<String, dynamic>);
      refundJsonData.addAll(mock["rawData"] as Map<String, dynamic>);

      final RefundSuccessDataModel refundData = RefundSuccessDataModel.fromJson(refundJsonData);
      // String status = response.data["status"] ?? "";
      var status = mock["status"];
      if (status == "Complete") {
        emit(state.copyWith(refundSuccessData: refundData, refundSuccessStatus: GetRefundSuccessDataStatus.success));
      } else {
        emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
    }
  }
}
