import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/widgets/common_app_bar.dart';
import 'package:sslcquiz/widgets/common_text.dart';
import 'package:sslcquiz/utils/colors.dart';
import 'package:sslcquiz/widgets/spacing_widget.dart';

import '../../utils/text_data.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    String aboutUs = '''
Privacy Policy

The Quiz App was developed by SSLC Quiz App as a free application. SSLC Quiz App is offering this SERVICE at no cost, and it should be used exactly as is.

This Privacy Policy explains our policies regarding the collection, use, and disclosure of information for users who choose to use our Service.

By choosing to use our Service, you agree to the collection and use of information in accordance with this policy. The information we collect is used solely to provide and improve the Service. We will not share or disclose your information with anyone except as described in this Privacy Policy.

Unless otherwise defined in this Privacy Policy, terms used here have the same meanings as in our Terms and Conditions, which are available within the app or on our [Terms of Use link, if applicable].

1. Information Collection and Use
The Quiz App is designed for educational and entertainment purposes.
We may collect non-personal information such as your quiz scores, selected language, and progress to improve your experience. This data is stored locally on your device unless you choose to back it up through your device’s systems.

We do not require personally identifiable information (such as your name, email, or phone number) for core quiz functionality.

If future versions of the app allow features like leaderboards, cloud sync, or user accounts, you will be informed before any information is collected, and your consent will be required.

2. Third-Party Services
Currently, the Quiz App does not use third-party services that collect personal data.

If in the future we integrate any trusted third-party services (e.g., analytics or ads), this Privacy Policy will be updated, and links to their policies will be provided within the app.

3. Service Providers
We do not employ third-party companies or individuals to operate or maintain the current version of the Quiz App. All app functions run locally on your device.

4. Security
Since we do not store personal information on our servers, risks of data breaches are minimal. However, we recommend keeping your device secure to protect any locally stored quiz progress or settings.

5. Links to Other Websites
The Quiz App does not contain links to external websites by default. If future versions include such links, they will be clearly marked, and you are advised to review the privacy policies of those websites.

6. Children’s Privacy
The Quiz App is suitable for users of all ages but is not specifically targeted toward children under 13. We do not knowingly collect personal data from children. If you believe a child under 13 has provided any personal information through the app, please contact us so we can remove it.

7. Changes to This Privacy Policy
We may update this Privacy Policy occasionally. You are advised to review this page periodically for any changes. We will notify you of significant updates via an in-app notice or other suitable methods.

This policy is effective as of August 13, 2025.

8. Contact Us
If you have any questions or suggestions about this Privacy Policy, please contact us at:
Email: vichruth.victorious@gmail.com
Phone: +91 7904815700
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
              title: TextData.contactUs,
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
