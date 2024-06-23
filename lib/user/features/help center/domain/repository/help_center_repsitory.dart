import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/send_help_request_use_case.dart';

abstract class HelpCenterRepository {
  Future<Either<Failure, void>> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  });
  Future<Either<Failure, List<HelpRequest>>> getAllUserRequests(
      {required String userID});
}
