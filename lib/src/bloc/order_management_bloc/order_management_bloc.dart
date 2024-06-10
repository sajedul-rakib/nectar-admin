import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_management_event.dart';
part 'order_management_state.dart';

class OrderManagementBloc extends Bloc<OrderManagementEvent, OrderManagementState> {
  OrderManagementBloc() : super(OrderManagementInitial()) {
    on<OrderManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
