
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'previous_scale_event.dart';

class PreviousScaleBloc extends Bloc<PreviousScaleEvent, double> {
  PreviousScaleBloc() : super(0.5) {
    on<PreviousScaleEvent>((event, emit) {
      emit(event.previousScale);
    });
  }
}
