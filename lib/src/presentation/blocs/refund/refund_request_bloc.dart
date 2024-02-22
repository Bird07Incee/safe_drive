import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_request_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'refund_request_event.dart';
part 'refund_request_state.dart';

class RefundRequestBloc extends Bloc<RefundRequestEvent, RefundRequestState> {
  final DioUtilityRepository utilityRepository;

  RefundRequestBloc({required this.utilityRepository})
      : super(RefundRequestState(
            getTextReason: TextEditingController(), getTextRemark: TextEditingController(), orderNo: "", refundResponse: const {})) {
    on<RefundRequestEvent>((event, emit) {
// TODO: implement event handler
    });

    on<SetRefundData>(_onSetRefundData);
    on<OnSelectReason>(_onSelectReason);
    on<OnEditRemark>(_onEditRemark);
    on<OnSubmitRefundData>(_onSubmit);
  }

  _onSetRefundData(SetRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    final inquriyPath = Environment().getValue("INQUIRY_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.orderNo, "uid": uid};

    try {
      Response response =
          await utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload, headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        if (event.reasonList!.isNotEmpty) {
          emit(state.copyWith(
              inquiryData: inquiryData,
              reasonList: event.reasonList,
              refundRequestData: RefundRequestModel(
                  status: status,
                  refundInfo: RefundInfoModel(
                    refundNo: event.orderNo,
                    refundDate: '',
                    refundTime: '',
                    reason: '',
                    remark: '',
                  ),
                  product: null),
              refundRequestStatus: GetRefundRequestStatus.success));
        }
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }

  _onSelectReason(OnSelectReason event, Emitter<RefundRequestState> emit) async {
    //   emit(state.copyWith(refundRequestData: RefundRequestModel(refundInfo: RefundInfoModel(reason: reason, refundNo: '', refundDate: '', refundTime: '', remark: ''), status: '', product: null),
    //       refundRequestStatus: GetRefundRequestStatus.success));
    emit(state.copyWith(
        refundRequestData: event.refundRequestModel,
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onEditRemark(OnEditRemark event, Emitter<RefundRequestState> emit) async {
    //   emit(state.copyWith(refundRequestData: RefundRequestModel(refundInfo: RefundInfoModel(reason: reason, refundNo: '', refundDate: '', refundTime: '', remark: ''), status: '', product: null),
    //       refundRequestStatus: GetRefundRequestStatus.success));
    emit(state.copyWith(
        refundRequestData: event.refundRequestModel,
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onSubmit(OnSubmitRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();

    try {
      String path = "/v1/refund";
      var data = {"orderNo": state.inquiryData.invoiceNo!, "reason": state.getTextReason.text, "remark": state.getTextRemark.text};
      Response response = await utilityRepository.postByURL("$baseUrl$transactionApiPath$path", data, headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response.statusCode == 200) {
        // var mock = {
        //   "status": "Complete",
        //   "refundInfo": {
        //     "refundNo": "RFLA20240215100358LXVdT",
        //     "refundDate": "21 กุมภาพันธ์ 2567",
        //     "refundTime": "18:32:17",
        //     "reason": "test reason ipp",
        //     "remark": "test remark ipp"
        //   },
        //   "rawData": {
        //     "invoiceNo": "LA20240215100138ZKR6H",
        //     "cardNo": "XXXXXXXXXXXX0006",
        //     "paymentDate": "15 กุมภาพันธ์ 2567",
        //     "paymentTime": "10:03:20",
        //     "paymentGateway": "บัตรเครดิต/บัตรเดบิต (ผ่าน 2C2P)",
        //     "paymentChannel": "IPP",
        //     "amount": "47,890",
        //     "merchantFullName": "ChocoCard Store",
        //     "merchantAddress": "2150/4  ถนนสุขุมวิท บางจาก พระโขนง กรุงเทพมหานคร 10260",
        //     "merchantMobile": "0123456789",
        //     "productImagePath":
        //         "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20231225_035156_Privilege_XK099RS.png?sv=2020-08-04&se=2028-11-28T08%3A51%3A56Z&sr=b&sp=r&sig=1aVZGa3bm5eiP5sU9mwhgw5z5Vb7XBWxwz%2BO6i%2Flghs%3D",
        //     "productId": "PV_2Q3HC9TC7ONG",
        //     "productOption": " Kook EV 2 Opt 3 Mer1 สายสีน้ำเงิน",
        //     "productName": "Pulsa Max Kook EV 2 Opt 1 Mer1 ",
        //     "customerFullname": "sss",
        //     "customerMobile": "0810155211",
        //     "customerEmail": "atirat.chunsith@gmail.com",
        //     "customerAddress": "23  คันนายาว คันนายาว กรุงเทพมหานคร 10230",
        //     "installmentPeriod": "10",
        //     "paymentChannelText": "ผ่อนชำระ 10 เดือน "
        //   }
        // };
        var refundResponse = response.data as Map<String, dynamic>;
        emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.submitSuccess, refundResponse: refundResponse));
      }
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.submitFail));
    }
  }
}
