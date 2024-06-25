part of 'order_management_bloc.dart';

abstract class OrderManagementState extends Equatable {
  const OrderManagementState();

  @override
  List<Object> get props => [];
}

final class OrderManagementInitial extends OrderManagementState {}

final class GetOrderDataLoading extends OrderManagementState {}

final class GetOrderDataSuccess extends OrderManagementState {
  final List<OrderDataModel> orderData;
  const GetOrderDataSuccess({required this.orderData});
}

final class GetOrderDataFailed extends OrderManagementState {
  final String errorMessage;
  const GetOrderDataFailed({required this.errorMessage});
}
