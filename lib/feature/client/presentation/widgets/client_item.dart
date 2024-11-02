import 'package:doktor_randevu/core/di/injection.dart';
import 'package:doktor_randevu/core/util/style.dart';
import 'package:doktor_randevu/feature/client/data/models/client_model.dart';
import 'package:doktor_randevu/feature/client/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/assets.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({
    super.key,
    required this.client,
    required this.isSelected,
  });

  final ClientModel client;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final Style _style = sl<Style>();
    String initials = client.name.isNotEmpty ? client.name.split(' ').map((e) => e[0].toUpperCase()).take(2).join() : '';
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.read<ClientBloc>().add(
              ClientSelectedEvent(
                clientId: client.id!,
              ),
            );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? _style.color(color: 'main_color') : _style.color(color: 'list_tile_bg'),
          shape: BoxShape.rectangle,
          border: Border.all(color: _style.color(color: 'list_tile_stroke'), width: .5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16), // Card padding
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: isSelected ? _style.color(color: 'white') : _style.color(color: 'circle_avatar_color'),
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'PublicSans',
                    color: isSelected ? _style.color(color: 'main_color') : _style.color(color: 'white'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.bold,
                        color: isSelected ? _style.color(color: 'white') : _style.color(color: 'main_text_color'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.phone,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PublicSans',
                        color: isSelected ? _style.color(color: 'white') : _style.color(color: 'grey_text_color'),
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                Assets.people,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  isSelected ? _style.color(color: 'white') : _style.color(color: 'main_text_color'),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
