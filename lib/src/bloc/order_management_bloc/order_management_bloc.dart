import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repo/model/order_data_model.dart';
import 'package:product_repo/product_repository.dart';

part 'order_management_event.dart';
part 'order_management_state.dart';

class OrderManagementBloc
    extends Bloc<OrderManagementEvent, OrderManagementState> {
  final ProductRepo productRepo;
  OrderManagementBloc({required this.productRepo})
      : super(OrderManagementInitial()) {
    //ger order data
    on<OrderManagementEvent>((event, emit) async {
      try {
        emit(GetOrderDataLoading());
        final orders = await productRepo.getOrderData();
        emit(GetOrderDataSuccess(orderData: orders));
      } catch (e) {
        emit(GetOrderDataFailed(errorMessage: e.toString()));
        rethrow;
      }
    });
  }
}
