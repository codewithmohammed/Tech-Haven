import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lotties/loading_lottie.json',
          height: 20,
          width: 20,
        ),
        // Uncomment the code below to use StreamBuilder with upload progress
        // child:StreamBuilder<double>(
        //         stream: dataSourceImpl.uploadProgressStream,
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             // Show loading indicator or any other widget indicating progress
        //             return Center(
        //               child: Lottie.asset('assets/lotties/loading_lottie.json'),
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
      ),
    );
  }
}
