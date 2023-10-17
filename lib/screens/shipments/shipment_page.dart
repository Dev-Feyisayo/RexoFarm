import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexofarm/screens/shipments/new_request_details_page.dart';
import 'package:rexofarm/utilities/constants.dart';
import 'package:rexofarm/view_models/home_view_model.dart';
import 'package:rexofarm/widgets/accepted_delivery_card.dart';
import 'package:rexofarm/widgets/request_card.dart';
import 'package:rexofarm/widgets/shimmer_widget.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({Key? key}) : super(key: key);

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage>
    with AutomaticKeepAliveClientMixin<ShipmentPage> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(
      context,
      listen: false,
    ).loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = Provider.of<HomeViewModel>(context, listen: true);
    final requests = provider.requests;
    final deliveries = provider.deliveries;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shipment'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: kAppPrimaryColor,
            isScrollable: true,
            unselectedLabelColor: Colors.black26,
            indicatorColor: kAppPrimaryColor,
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('New Requests'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Accepted'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Completed'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Ongoing'),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: kPagePadding,
          child: TabBarView(
            children: [
              requests == null
                  ? const ShimmerWidget(type: ShimmerType.shipment)
                  : requests.isEmpty
                      ? RefreshIndicator(
                          onRefresh: refreshData,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              Center(
                                child: Text('No new requests yet'),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: refreshData,
                          child: ListView.builder(
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              return RequestCard(
                                pickupRequest: requests[index],
                                onTap: () async {
                                  bool? isAccepted = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return NewRequestDetailsPage(
                                        pickupRequest: requests[index],
                                      );
                                    }),
                                  );

                                  if (isAccepted == true) {
                                    if (context.mounted) {
                                      Provider.of<HomeViewModel>(
                                        context,
                                        listen: false,
                                      ).refreshData();
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ),
              deliveries == null
                  ? const ShimmerWidget(type: ShimmerType.shipment)
                  : deliveries.isEmpty
                      ? RefreshIndicator(
                          onRefresh: refreshData,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              Center(
                                child: Text('No accepted requests yet'),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: refreshData,
                          child: ListView.builder(
                            itemCount: deliveries.length,
                            itemBuilder: (context, index) {
                              return AcceptedDeliveryCard(
                                acceptedDelivery: deliveries[index],
                              );
                            },
                          ),
                        ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text('No completed requests yet'),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text('No ongoing requests yet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> refreshData() async {
    Provider.of<HomeViewModel>(
      context,
      listen: false,
    ).refreshData();
  }
}
