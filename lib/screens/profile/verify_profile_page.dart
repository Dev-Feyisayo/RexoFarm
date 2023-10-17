import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rexofarm/layouts/home_icons_icons.dart';
import 'package:rexofarm/utilities/constants.dart';

class VerifyProfilePage extends StatefulWidget {
  const VerifyProfilePage({Key? key}) : super(key: key);

  @override
  State<VerifyProfilePage> createState() => _VerifyProfilePageState();
}

class _VerifyProfilePageState extends State<VerifyProfilePage> {
  double percentage = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFFFF8E2),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            HomeIcons.timer,
                            color: Color(0xFFCA7C21),
                          ),
                          Text(
                            'Profile verification in progress. Please await authorization.',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF794B14)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFEBFFE5),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            HomeIcons.tick_circle,
                            size: 28,
                            color: Color(0xFF008A2B),
                          ),
                          Text(
                            'Your profile is now verified!',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF005316)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearPercentIndicator(
                      percent: percentage,
                      progressColor: Colors.green,
                      trailing: Text(
                        '${(percentage * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Driver\'s license',
                      style: TextStyle(
                        color: Color(0xFF006E21),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const SizedBox(
                        height: double.infinity,
                        child: Icon(
                          HomeIcons.file_png,
                          color: Color(0xFF006E21),
                        ),
                      ),
                      title: const Text(
                        'driverslicense - front.png',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      subtitle: const Text(
                        '04 Oct. 2023 | 12:20 pm - 2.3MB',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFFBA1A1A),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.refresh,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 2),
                    ListTile(
                      leading: const SizedBox(
                        height: double.infinity,
                        child: Icon(
                          HomeIcons.file_png,
                          color: Color(0xFF006E21),
                        ),
                      ),
                      title: const Text(
                        'driverslicense - back.png',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      subtitle: const Text(
                        '04 Oct. 2023 | 12:20 pm - 2.3MB',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFFBA1A1A),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.refresh,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 2),
                    const SizedBox(height: 10),
                    const Text(
                      'NIN Slip',
                      style: TextStyle(
                        color: Color(0xFF006E21),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Front image',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DottedBorder(
                      color: const Color.fromRGBO(0, 110, 33, 1),
                      strokeWidth: 1,
                      dashPattern: const [15, 15],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          color: const Color(0xFFFCFDF6),
                          width: double.infinity,
                          height: 80,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              const Icon(Icons.upload),
                              const SizedBox(height: 15),
                              Text.rich(
                                TextSpan(
                                    text: 'Click to upload ',
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(
                                          color: kAppPrimaryColor,
                                          fontWeightDelta: 2,
                                          fontSizeDelta: -1,
                                        ),
                                    children: const [
                                      TextSpan(
                                          text: 'front image of your NIN Slip',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
