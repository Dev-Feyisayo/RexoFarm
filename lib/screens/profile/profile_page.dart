import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/screens/auth/login_page.dart';
import 'package:rexofarm/screens/profile/change_password_page.dart';
import 'package:rexofarm/screens/profile/vehicle_mgt_page.dart';
import 'package:rexofarm/screens/profile/verify_profile_page.dart';
import 'package:rexofarm/utilities/alert_utils.dart';
import 'package:rexofarm/utilities/constants.dart';
import 'package:rexofarm/utilities/navigation_utils.dart';
import 'package:rexofarm/view_models/home_view_model.dart';
import 'package:rexofarm/view_models/profile_view_model.dart';
import 'package:rexofarm/widgets/profile_extra_card.dart';
import 'package:rexofarm/widgets/profile_setting_tile.dart';

class ProfilePage extends StatelessWidget with AlertUtils {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driver = Provider.of<HomeViewModel>(context, listen: true).driver;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'images/profile/menu_edit.png',
                width: 30,
                height: 28,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 18, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 39,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        driver?.firstName == null
                            ? "No name"
                            : '${driver?.firstName} ${driver?.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: const Text('Driver'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: ProfileExtraCard(
                      widgetTitle: Text(
                        '17',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      description: 'Completed Shipments',
                    ),
                  ),
                  Expanded(
                    child: ProfileExtraCard(
                      widgetTitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '4.5',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber,
                          )
                        ],
                      ),
                      description: 'Avg. customer rating',
                    ),
                  ),
                  Expanded(
                    child: ProfileExtraCard(
                      widgetTitle: Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green,
                      ),
                      description: 'Verified Driver',
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ProfileSettingTile(
                fileName: 'profile.png',
                title: 'Account information',
                subtitle: 'Name, Phone number, Email address, etc',
                onPressed: () {},
              ),
              ProfileSettingTile(
                fileName: 'lock.png',
                title: 'Password',
                subtitle: 'Change your password',
                onPressed: () {
                  NavigationUtils.goTo(context, const ChangePasswordPage());
                },
              ),
              ProfileSettingTile(
                fileName: 'group.png',
                title: 'Vehicle management',
                subtitle: 'Vehicle Name, Number Plate, etc',
                onPressed: () async {
                  NavigationUtils.goTo(context, const VehicleManagementPage());
                },
              ),
              ProfileSettingTile(
                fileName: 'tick-circle.png',
                title: 'Verify profile',
                subtitle: 'Complete KYC to verify profile',
                onPressed: () {
                  NavigationUtils.goTo(context, const VerifyProfilePage());
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'Payment',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ProfileSettingTile(
                fileName: 'payment.png',
                title: 'Payment account',
                subtitle: 'Account to withdraw funds into',
                onPressed: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'Help & Support',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ProfileSettingTile(
                fileName: 'clipboard-text.png',
                title: 'Terms of service',
                onPressed: () {},
              ),
              ProfileSettingTile(
                fileName: 'security-user.png',
                title: 'Privacy policy',
                onPressed: () {},
              ),
              ProfileSettingTile(
                fileName: 'messages.png',
                title: 'Customer support',
                onPressed: () {},
              ),
              ProfileSettingTile(
                fileName: 'close-circle.png',
                title: 'Delete account',
                subtitle: 'Delete your Rexofarm account',
                color: kDeepRed,
                onPressed: () {},
              ),
              ProfileSettingTile(
                fileName: 'logout.png',
                title: 'Logout',
                color: kDeepRed,
                onPressed: () async {
                  showLoadingAlert(context, text: 'Logging out');
                  await Provider.of<ProfileViewModel>(
                    context,
                    listen: false,
                  ).logout();
                  if (context.mounted) {
                    Provider.of<HomeViewModel>(
                      context,
                      listen: false,
                    ).deleteCurrentUserData();
                    dismissLoader(context);

                    NavigationUtils.clearStackAndGoTo(
                      context,
                      const LoginPage(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
