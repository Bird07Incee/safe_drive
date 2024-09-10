import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScrollControllerCubit extends Cubit<HomeScrollControllerCubitState> {
  HomeScrollControllerCubit() : super(HomeScrollControllerCubitState());

  // Create methods to update the variables and emit the state
  void updateScrollController({
    double? scrollControllerPosition,
  }) {
    emit(state.copyWith(scrollControllerPosition: scrollControllerPosition));
  }
}

class HomeScrollControllerCubitState extends Equatable {
  final double scrollControllerPosition;

  const HomeScrollControllerCubitState({
    this.scrollControllerPosition = 0,
  });

  HomeScrollControllerCubitState copyWith({
    double? scrollControllerPosition,
  }) {
    return HomeScrollControllerCubitState(
      scrollControllerPosition: scrollControllerPosition ?? 0,
    );
  }

  @override
  List<Object?> get props => [scrollControllerPosition];
}
