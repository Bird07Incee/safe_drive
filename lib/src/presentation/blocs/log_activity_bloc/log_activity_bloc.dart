import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/model/activity_model/activity_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

part 'log_activity_event.dart';
part 'log_activity_state.dart';

final LogActivityBloc logActivityBloc = LogActivityBloc(
  utilityRepository: DioUtilityRepository(service: DioUtilityService(dio: DioClient.client)),
);

class LogActivityBloc extends Bloc<LogActivityEvent, LogActivityState> {
  final DioUtilityRepository utilityRepository;
  LogActivityBloc({required this.utilityRepository}) : super(LogActivityInitial()) {
    on<SendLogEvent>(_onLogActivityEvent);
  }

  void _onLogActivityEvent(SendLogEvent event, Emitter<LogActivityState> emit) async {
    emit(LogActivityLoading());
    final logActivityBaseURL = Environment().getValue("LOG_ACTIVITY_BASE_URL");
    try {
      Response response = await utilityRepository.postByURL("$logActivityBaseURL/activities", event.payload);
      final ActivityLogResponseModel responseData = ActivityLogResponseModel.fromJson(response.data);
      DatadogSdk.instance.rum?.addAction(RumActionType.custom, "activity log Bloc : ${response.data}");
      emit(LogActivitySuccess(responseData));
    } catch (e) {
      DatadogSdk.instance.rum?.addError("activity log Bloc Error : $e", RumErrorSource.custom);
      emit(LogActivityError(e.toString()));
    }
  }
}
