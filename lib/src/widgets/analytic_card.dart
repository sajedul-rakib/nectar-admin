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
            crossAxisCount: !AppResponsive.isDesktop(context) ? 2 : 4,
            childAspectRatio:
                !AppResponsive.isDesktop(context) ? 1.4 / .5 : 1 / .5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0),
        itemBuilder: (context, index) => AnalyticInfoCard(
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
      width: !AppResponsive.isDesktop(context) ? 200 : 100,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.successGreen.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      analyticData.value,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen),
                    ),
                    Text(
                      analyticData.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.successGreen.withOpacity(.4)),
                  child: (Icon(
                    analyticData.iconData,
                    color: AppColors.successGreen,
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
