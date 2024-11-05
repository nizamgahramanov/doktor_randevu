import 'package:doktor_randevu/core/constant/assets.dart';
import 'package:doktor_randevu/core/util/global_functions.dart';
import 'package:doktor_randevu/core/widgets/custom_app_bar.dart';
import 'package:doktor_randevu/core/widgets/custom_elevated_button.dart';
import 'package:doktor_randevu/core/widgets/loading_widget.dart';
import 'package:doktor_randevu/core/widgets/page_status.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/presentation/bloc/bloc.dart';
import 'package:doktor_randevu/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ConclusionScreen extends StatefulWidget {
  static const routeName = '/booking';

  const ConclusionScreen({
    Key? key,
    required this.conclusion,
  }) : super(key: key);
  final Conclusion conclusion;
  @override
  State<ConclusionScreen> createState() => _ConclusionScreenState();
}

class _ConclusionScreenState extends State<ConclusionScreen> {
  final Style _style = sl<Style>();
  final bookingBloc = sl<BookingBloc>();
  final TextEditingController bookNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String initials = widget.conclusion.clientName != null ? widget.conclusion.clientName!.split(' ').map((e) => e[0].toUpperCase()).take(2).join() : '';

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: Text(
          widget.conclusion.title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.bold,
            color: _style.color(
              color: 'secondary_grey_color',
            ),
          ),
        ),
        actionButton: widget.conclusion.isBookInfo
            ? [
                /*InkWell(
                  onTap: () {
                    openEditModalBottomSheet();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4, right: 16, bottom: 4),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _style.color(color: 'main_grey_color'),
                      ),
                      child: SvgPicture.asset(Assets.edit),
                    ),
                  ),
                ),*/
              ]
            : [],
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.patient.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'PublicSans',
                              color: _style.color(color: 'secondary_text_color'),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: _style.color(color: 'list_tile_bg'),
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
                                    backgroundColor: _style.color(color: 'circle_avatar_color'),
                                    child: Text(
                                      initials,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'PublicSans',
                                        color: _style.color(color: 'white'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.conclusion.clientName!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.bold,
                                            color: _style.color(color: 'main_text_color'),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          widget.conclusion.clientPhone!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'PublicSans',
                                            color: _style.color(color: 'grey_text_color'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.bookingDetails.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'PublicSans',
                              color: _style.color(color: 'secondary_text_color'),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.date),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.conclusion.date!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.time),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.conclusion.startTime!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                ),
                                SvgPicture.asset(Assets.arrowRight),
                                Text(
                                  widget.conclusion.endTime!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.service),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.conclusion.serviceName}-  ${widget.conclusion.serviceDuration} ${AppLocalizations.of(context)!.minute} ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SvgPicture.asset(Assets.serviceDuration),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.conclusion.patientNote != null && widget.conclusion.patientNote != ''
                        ? Container(
                            margin: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.patientNote.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'secondary_text_color'),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.conclusion.patientNote!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'PublicSans',
                                    color: _style.color(color: 'main_text_color'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    if (!widget.conclusion.isBookInfo)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.bookNote.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'PublicSans',
                                color: _style.color(color: 'secondary_text_color'),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextFormField(
                              controller: bookNoteController,
                              maxLines: 5,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {},
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (!widget.conclusion.isBookInfo)
              BlocProvider(
                create: (context) => bookingBloc,
                child: BlocListener<BookingBloc, BookingState>(
                  listener: (context, state) {
                    if (state.pageStatus is DataSubmitted) {
                      GlobalFunctions.instance.showCloseDialog(
                          title: AppLocalizations.of(context)!.randevuCreated,
                          svgPath: Assets.checkMark,
                          buttonBackground: _style.color(color: 'main_color'),
                          context: context,
                          onButtonPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const IndexScreen(
                                        index: 1,
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          });
                      bookingBloc.add(SendPushNotificationEvent(conclusion: widget.conclusion, heading: AppLocalizations.of(context)!.bookCreatedPushNotificationHeading));
                    } else if (state.pageStatus is DataSubmitFailed) {
                      GlobalFunctions.instance.showCloseDialog(
                          title: AppLocalizations.of(context)!.failure,
                          svgPath: Assets.checkMark,
                          buttonBackground: _style.color(color: 'main_color'),
                          context: context,
                          onButtonPressed: () {
                            Navigator.of(context).pop();
                          });
                    }
                  },
                  child: CustomElevatedButton(
                    buttonText: AppLocalizations.of(context)!.finishAndCreate,
                    backgroundColor: _style.color(color: bookingBloc.state.pageStatus is DataLoading ? 'deActive_indicator' : 'main_color'),
                    loadingIcon: bookingBloc.state.pageStatus is DataLoading
                        ? const LoadingWidget(
                            size: 24,
                          )
                        : null,
                    onPressed: () {
                      widget.conclusion.bookNote = bookNoteController.text;
                      bookingBloc.add(CreateBookEvent(conclusion: widget.conclusion));
                    },
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: 8,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void openEditModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CustomElevatedButton(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            buttonText: AppLocalizations.of(context)!.create,
            onPressed: () async {
                bookingBloc.add(CancelBookingEvent(bookingId: widget.conclusion.bookingId!));
            },
            backgroundColor: _style.color(color: 'main_color'),
          ),
        );
      },
    );
  }
}
