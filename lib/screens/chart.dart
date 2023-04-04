import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "64%",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xFF7fe1ad),
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: const Color(0xFF7fe1ad),
    value: 64,
    showTitle: false,
    radius: 6,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 36,
    showTitle: false,
    radius: 6,
  ),
];

class Chart1 extends StatelessWidget {
  const Chart1({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas1,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "40%",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xFFf85f6a),
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                // Text(
                //   "Devices",
                //   style: Theme.of(context).textTheme.headline6!.copyWith(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500,
                //         height: 0.5,
                //       ),
                // ),
                // Text("of 128GB")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas1 = [
  PieChartSectionData(
    color: const Color(0xFFf85f6a),
    value: 40,
    showTitle: false,
    radius: 6,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 60,
    showTitle: false,
    radius: 6,
  ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
];

class Chart2 extends StatelessWidget {
  const Chart2({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas2,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  "90%",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xFF898a9c),
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),

                // Text("of 128GB")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas2 = [
  PieChartSectionData(
    color: const Color(0xFF898a9c),
    value: 90,
    showTitle: false,
    radius: 6,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 10,
    showTitle: false,
    radius: 6,
  ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
  // PieChartSectionData(
  //   color: primaryColor.withOpacity(0.1),
  //   value: 25,
  //   showTitle: false,
  //   radius: 10
  // ,
  // ),
];

class Chart3 extends StatelessWidget {
  const Chart3({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas3,
            ),
          ),
          Row(),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 215, 0),
                  child: Text(
                    "attention : 33.33%",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          height: 0.5,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.fromLTRB(200, 0, 0, 30),
                  child: Text(
                    "official : 66.67%",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 0.5,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas3 = [
  PieChartSectionData(
    color: Colors.red,
    value: 67,
    showTitle: false,
    radius: 40,
  ),
  PieChartSectionData(
    color: Colors.yellow.withOpacity(0.7),
    value: 33,
    showTitle: false,
    radius: 40,
  ),
];
