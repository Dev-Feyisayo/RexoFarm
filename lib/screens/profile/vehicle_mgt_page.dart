import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/screens/profile/add_vehicle_details_page.dart';
import 'package:rexofarm/utilities/alert_utils.dart';
import 'package:rexofarm/utilities/constants.dart';
import 'package:rexofarm/utilities/navigation_utils.dart';
import 'package:rexofarm/view_models/home_view_model.dart';
import 'package:rexofarm/view_models/profile_view_model.dart';
import 'package:rexofarm/widgets/registered_vehicle_card.dart';
import 'package:rexofarm/widgets/shimmer_widget.dart';

class VehicleManagementPage extends StatefulWidget {
  const VehicleManagementPage({Key? key}) : super(key: key);

  @override
  State<VehicleManagementPage> createState() => _VehicleManagementPageState();
}

class _VehicleManagementPageState extends State<VehicleManagementPage>
    with AlertUtils {
  @override
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).init(
      Provider.of<HomeViewModel>(context, listen: false).token!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<ProfileViewModel>(
      context,
      listen: true,
    ).vehicles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
      ),
      body: Padding(
        padding: kPagePadding,
        child: SafeArea(
          child: vehicles == null
              ? const ShimmerWidget(type: ShimmerType.shipment)
              : vehicles.isEmpty
                  ? const Center(
                      child: Text('No vehicle added yet'),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        Provider.of<ProfileViewModel>(
                          context,
                          listen: false,
                        ).refreshData();
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return RegisteredVehicleCard(
                                  vehicle: vehicles[index],
                                );
                              },
                              childCount: vehicles.length,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                      horizontal: 16.0,
                                    ),
                                    side: const BorderSide(
                                        color: kAppPrimaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () => NavigationUtils.goTo(
                                    context,
                                    AddVehicleDetailsPage(),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(width: 8),
                                      Text('Add Vehicle')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
