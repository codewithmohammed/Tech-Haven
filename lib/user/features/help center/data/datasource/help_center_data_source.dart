import 'package:tech_haven/core/common/data/model/help_request_model.dart';
import 'package:tech_haven/core/entities/help_request.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/get_all_user_requests.dart';
import 'package:tech_haven/user/features/help%20center/domain/usecase/send_help_request_use_case.dart';

abstract class HelpCenterDataSource {
  Future<void> sendHelpRequest({
    required String userID,
    required String userName,
    required HelpRequest helpRequest,
  });

  Future<List<HelpRequestModel>> getAllUserRequests(
       {required String userID});
}
