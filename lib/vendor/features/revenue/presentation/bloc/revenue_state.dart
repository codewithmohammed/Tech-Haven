part of 'revenue_bloc.dart';

sealed class RevenueState extends Equatable {
  const RevenueState();

  @override
  List<Object> get props => [];
}

final class RevenueInitial extends RevenueState {}

final class RevenueLoading extends RevenueState {}

final class GetRevenueSuccess extends RevenueState {
  final Revenue revenue;
  const GetRevenueSuccess({required this.revenue});
}

final class GetRevenueFailed extends RevenueState {
  final String message;
  const GetRevenueFailed({required this.message});
}

final class GetListOfRevenueDataState extends RevenueState {}

final class GetListOfRevenueDataLoadingState
    extends GetListOfRevenueDataState {}

final class GetListOfRevenueDataSuccessState extends GetListOfRevenueDataState {
  final List<VendorPayment> listOfVendorPayment;
  GetListOfRevenueDataSuccessState({required this.listOfVendorPayment});
}

final class GetListOfRevenueDataFailedState extends GetListOfRevenueDataState {
  final String message;
  GetListOfRevenueDataFailedState({required this.message});
}
