import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/widgets/common_app_bar.dart';
import 'package:sslcquiz/widgets/common_text.dart';
import 'package:sslcquiz/utils/colors.dart';
import 'package:sslcquiz/widgets/spacing_widget.dart';

import '../../utils/text_data.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    const String aboutUs = '''
SSLC Quiz is an India-based educational mobile application designed to make exam preparation simple, effective, and engaging for students. Our goal is to provide learners with a convenient, accessible, and enjoyable platform to test their knowledge and improve their skills.

Our mission is to help SSLC students prepare with confidence by offering a wide range of quiz questions, covering key subjects and concepts. Whether you’re revising before exams or testing yourself after studying, SSLC Quiz is here to make learning interactive and productive.

We are committed to creating a safe and secure learning experience. SSLC Quiz does not collect or store personal data, ensuring complete privacy for our users.

Our Goal:
To deliver high-quality, trustworthy, and easy-to-use learning tools that empower students to succeed in their SSLC examinations.

For more queries you can email us at: vichruth.victorious@gmail.com
or call us on +91 79 0481 5700
''';

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: getGradient(),
        child: Column(
          children: [
            CommonAppBar(
              title: TextData.aboutUs,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ).paddingSymmetric(horizontal: 15),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing.height(10),
                      CommonText(
                        text: aboutUs,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      // Spacing.height(4),
                      // CommonText(
                      //   text: 'support@yourapp.com',
                      //   fontSize: 14,
                      //   color: AppColors.blackColor,
                      // ),
                      // Spacing.height(20),
                      // CommonText(
                      //   text: 'Phone',
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      // Spacing.height(4),
                      // CommonText(
                      //   text: '+91 9876543210',
                      //   fontSize: 14,
                      //   color: AppColors.blackColor,
                      // ),
                      // Spacing.height(20),
                      // CommonText(
                      //   text: 'Address',
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      // Spacing.height(4),
                      // CommonText(
                      //   text: '123, Quiz Avenue, Kerala, India',
                      //   fontSize: 14,
                      //   color: AppColors.blackColor,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
