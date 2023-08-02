import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/models/api_response.dart';
import 'package:rexofarm/screens/kyc_upload/vehicle_images_page.dart';
import 'package:rexofarm/utilities/alert_utils.dart';
import 'package:rexofarm/utilities/navigation_utils.dart';
import 'package:rexofarm/utilities/constants.dart';
import 'package:rexofarm/view_models/auth_view_model.dart';
import 'package:rexofarm/view_models/kyc_view_model.dart';
import 'package:rexofarm/widgets/app_dropdown_dialog.dart';
import 'package:rexofarm/widgets/form_header_card.dart';
import 'package:rexofarm/widgets/input_field.dart';
import 'package:rexofarm/validators.dart';

class VehicleDetailsPage extends StatelessWidget with AlertUtils {
  final _formKey = GlobalKey<FormState>();

  VehicleDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          FormHeaderCard(
                            title: 'Upload Vehicle',
                            subtitle: 'Vehicle Details',
                            pageIndicatorCount: 0,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vehicle Type',
                                  style: TextStyle(
                                    color: Color.fromRGBO(26, 28, 25, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                AppDropdownDialog(
                                  description: 'Select your vehicle type',
                                  onSelected: (String type) {
                                    Provider.of<KycViewModel>(
                                      context,
                                      listen: false,
                                    ).vehicle.type = type;
                                  },
                                ),
                                const SizedBox(height: 16),
                                InputField(
                                  labelText: 'Vehicle Make',
                                  onSaved: (text) {
                                    Provider.of<KycViewModel>(
                                      context,
                                      listen: false,
                                    ).vehicle.make = text ?? '';
                                  },
                                  validator: Validators.validateVehicleType,
                                  hintText: 'Ford',
                                ),
                                const SizedBox(height: 16),
                                InputField(
                                  labelText: 'Vehicle Model',
                                  onSaved: (text) {
                                    Provider.of<KycViewModel>(
                                      context,
                                      listen: false,
                                    ).vehicle.model = text ?? '';
                                  },
                                  validator: Validators.validateVehicleType,
                                  hintText: 'Transit',
                                ),
                                const SizedBox(height: 16),
                                InputField(
                                  labelText: 'Number Plate',
                                  onSaved: (text) {
                                    Provider.of<KycViewModel>(
                                      context,
                                      listen: false,
                                    ).vehicle.plate = text ?? '';
                                  },
                                  validator: Validators.validateNumberPlate,
                                  hintText: 'ABC-123-XYZ',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => submitDetails(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: kAppPrimaryColor,
                        ),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        NavigationUtils.clearStackAndHome(context);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 110, 33, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submitDetails(BuildContext context) async {
    // NavigationUtils.goTo(context, const VehicleKycPage());
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      showLoadingAlert(context, text: 'Uploading vehicle');

      String token = Provider.of<AuthViewModel>(
        context,
        listen: false,
      ).userToken!;

      final response = await Provider.of<KycViewModel>(
        context,
        listen: false,
      ).uploadVehicleDetails(token);

      if (context.mounted) {
        dismissLoader(context);

        if (response.status == ResponseStatus.completedWithData) {
          NavigationUtils.goTo(context, const VehicleImagesPage());
        } else {
          showMessageAlert(
            context,
            title: 'Error occurred!',
            body: response.message!,
          );
        }
      }
    }
  }
}
