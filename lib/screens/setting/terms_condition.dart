import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sslcquiz/utils/constant.dart';
import 'package:sslcquiz/widgets/common_app_bar.dart';
import 'package:sslcquiz/widgets/common_text.dart';
import 'package:sslcquiz/utils/colors.dart';
import 'package:sslcquiz/utils/text_data.dart';
import 'package:sslcquiz/widgets/spacing_widget.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    const String aboutUs = '''
Terms of Use 

By downloading or using the Quiz App, these terms apply automatically. Therefore, you should read them carefully before using the app.

You are not permitted to copy or modify the Quiz App, any part of it, or our trademarks in any way. You may not attempt to extract the source code of the Quiz App, translate it, or create derivative works in any other language. The Quiz App itself, along with all related trademarks, copyrights, database rights, and other intellectual property rights, remain owned by SSLC Quiz App.

SSLC Quiz App is committed to making the Quiz App as useful and efficient as possible. As such, we reserve the right to make changes, add features, or provide new services in the future. Currently, the Quiz App is provided free of charge, offering educational and entertainment quiz functionalities. If any future services or features require payment, we will notify you clearly beforehand.

User Data and Privacy
The Quiz App does not require you to provide personal data for its core functionality. It is designed to operate primarily offline and stores any quiz progress or scores locally on your device.

If future features such as leaderboards, online accounts, or cloud sync are introduced, you will be informed, and your consent will be required before any personal data is collected.

Security and Device Responsibility
It is your responsibility to maintain the security of your device. We strongly advise against jailbreaking or rooting your phone, as this may make it vulnerable to malware or malicious software, which could impair the Quiz App’s functionality.

Third-Party Services
The current version of the Quiz App does not use any third-party services that have independent Terms of Use. All core functions are self-contained within the app.

Limitation of Liability
You should be aware of the following:

The Quiz App’s performance may vary depending on your device, operating system, and settings.

SSLC Quiz App is not responsible for how you use the Quiz App or for any consequences arising from its use.

You are responsible for ensuring your device is adequately charged and functional when using the app.

While we strive for accuracy in our quiz content and app performance, we do not guarantee that the Quiz App will be completely error-free or meet every specific learning requirement.

SSLC Quiz App is not liable for any loss (direct or indirect) resulting from your use or inability to use the Quiz App.

Updates and Availability
From time to time, updates to the Quiz App may be released via app stores. These may include new features, performance improvements, or bug fixes. We recommend installing updates promptly for the best experience.

The Quiz App is available for Android (and potentially other platforms). While we aim for wide compatibility, we do not guarantee support for all older devices or operating system versions indefinitely. We reserve the right to stop providing or updating the app without prior notice. Upon termination, your right to use the app will cease, and you should uninstall it from your device.

Changes to These Terms of Use
We may update our Terms of Use occasionally. You are encouraged to review this page periodically for any changes. Significant changes will be posted within the app or by other reasonable means.

These terms are effective as of August 13, 2025.

Inquiry / Contact:
Email: vichruth.victorious@gmail.com
Phone: +91 7904815700

These Terms of Use are provided by SSLC Quiz App.
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
              title:TextData.termsCondition,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ).paddingSymmetric(horizontal: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text:aboutUs,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,)
                      ],
                    ),
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
