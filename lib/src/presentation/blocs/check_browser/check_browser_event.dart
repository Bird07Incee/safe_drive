part of 'check_browser_bloc.dart';

class CheckBrowserEvent extends Equatable {
  const CheckBrowserEvent();
  @override
  List<Object> get props => [];
}

class GetBrowserClient extends CheckBrowserEvent {
  const GetBrowserClient({required this.context});
  final BuildContext context;
}
