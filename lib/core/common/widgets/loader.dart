import 'package:flutter/material.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source_impl.dart';

class Loader extends StatelessWidget {
  // final RegisterProductDataSourceImpl dataSourceImpl;
  const Loader({super.key});

  // final Stream<double>? stream;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
      // child:StreamBuilder<double>(
      //         stream: dataSourceImpl.uploadProgressStream,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             // Show loading indicator or any other widget indicating progress
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           } else if (snapshot.hasData) {
      //             // Show upload progress
      //             return Center(
      //               child: Text(
      //                   'Upload Progress: ${snapshot.data!.toStringAsFixed(2)}%'),
      //             );
      //           } else {
      //             // Show error message if upload fails
      //             return Center(
      //               child: Text('Upload failed'),
      //             );
      //           }
      //         },
      //       ),
    ));
  }
}
