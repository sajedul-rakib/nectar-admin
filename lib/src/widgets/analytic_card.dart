import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/analytic_data.dart';
import 'package:flutter/material.dart';

class AnalyticCardView extends StatelessWidget {
  const AnalyticCardView({super.key, required this.analyticData});

  final List<AnalyticData> analyticData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: analyticData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: !AppResponsive.isDesktop(context)
                ? AppResponsive.isTablet(context)
                    ? 2
                    : 1
                : 4,
            childAspectRatio:
                !AppResponsive.isDesktop(context) ? 1.4 / .6 : 1 / .7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0),
        itemBuilder: (_, index) => AnalyticInfoCard(
              analyticData: analyticData[index],
            ));
  }
}

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({super.key, required this.analyticData});

  final AnalyticData analyticData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.shadowColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                  ),
                  child: (Icon(
                    analyticData.iconData,
                    color: AppColors.blackColor,
                    size: 30,
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  analyticData.value,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor),
                ),
                Text(
                  analyticData.title,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
