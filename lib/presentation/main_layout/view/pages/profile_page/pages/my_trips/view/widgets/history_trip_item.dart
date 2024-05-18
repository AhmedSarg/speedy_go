import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speedy_go/app/extensions.dart';
import 'package:speedy_go/domain/models/domain.dart';
import 'package:speedy_go/presentation/resources/assets_manager.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/font_manager.dart';
import 'package:speedy_go/presentation/resources/styles_manager.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

class HistoryTripItem extends StatelessWidget {
  const HistoryTripItem({super.key, required this.tripModel});

  final TripBusModel tripModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.infinity,
      height: AppSize.s100,
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: ColorManager.veryLightGrey,
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(SVGAssets.redBus),
          const SizedBox(width: AppSize.s10),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.width() * .3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From: ',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.blue,
                                    fontSize: FontSize.f16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    tripModel.pickup,
                                    style: getMediumStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.f14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'To: ',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.blue,
                                    fontSize: FontSize.f16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    tripModel.destination,
                                    style: getMediumStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.f14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSize.s10),
                      Expanded(
                        child: Text(
                          'EGP ${tripModel.price}',
                          style: getSemiBoldStyle(
                            color: ColorManager.blue,
                            fontSize: FontSize.f18,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyy, HH:mm a').format(tripModel.date),
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.f12,
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
