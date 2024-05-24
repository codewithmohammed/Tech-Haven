import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class ShowPresentPaymentSheet implements UseCase<String, NoParams> {
  final CheckoutRepository checkoutRepository;
  ShowPresentPaymentSheet({required this.checkoutRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await checkoutRepository.showPresentPaymentSheet(
      );
  }
}
