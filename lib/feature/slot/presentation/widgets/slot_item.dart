import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/feature/slot/data/models/slot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/assets.dart';

class SlotItem extends StatelessWidget {
  const SlotItem({
    super.key,
    required this.slot,
    required this.isSelected,
  });

  final SlotModel slot;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {

      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      slot.date,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PublicSans',
                        color: _style.color(
                          color: isSelected?'main_color':'main_text_color',
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${slot.time}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PublicSans',
                        color: _style.color(
                          color: 'secondary_text_color',
                        ),
                      ), // Format duration as needed
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                isSelected ? SvgPicture.asset(Assets.checkMark,) : Container(),
              ],

            ),
          ),
          Divider(color: Colors.grey,indent: 16,)
        ],
      ),
    );
  }
}
