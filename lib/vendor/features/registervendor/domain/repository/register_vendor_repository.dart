import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class RegisterVendorRepository {
  Future<Either<Failure, String>> sendRequestForVendor({
    required User user,
    required String businessName,
    required File? businessPicture,
    required String physicalAddress,
    required String accountNumber,
  });

  Future<Either<Failure,String>> checkForVendorStatus({required String vendorID});
}
