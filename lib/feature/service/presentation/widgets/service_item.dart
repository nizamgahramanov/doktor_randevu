import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/feature/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/assets.dart';
import '../../data/models/service_model.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.service,
    required this.isSelected,
  });

  final ServiceModel service;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.read<ServiceBloc>().add(
              ServiceSelectedEvent(
                serviceId: service.id,
              ),
            );
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
                      service.name,
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
                      '${service.duration} ${AppLocalizations.of(context)!.minute}',
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
