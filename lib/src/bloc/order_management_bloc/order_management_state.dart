part of 'order_management_bloc.dart';

sealed class OrderManagementState extends Equatable {
  const OrderManagementState();
  
  @override
  List<Object> get props => [];
}

final class OrderManagementInitial extends OrderManagementState {}
