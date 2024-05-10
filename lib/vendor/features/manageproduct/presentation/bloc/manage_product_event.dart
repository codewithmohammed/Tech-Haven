part of 'manage_product_bloc.dart';

sealed class ManageProductEvent extends Equatable {
  const ManageProductEvent();

  @override
  List<Object> get props => [];
}



final class GetAllProductsEvent extends ManageProductEvent{

}