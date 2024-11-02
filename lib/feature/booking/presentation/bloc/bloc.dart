

import 'dart:async';


import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/feature/booking/data/models/booking_creation_response_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/conclusion.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/processed_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/create_booking.dart';
import 'package:doktor_randevu/feature/booking/domain/usecases/send_push_notification.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/page_status.dart';
import '../../data/models/booking_date_info.dart';
import '../../data/models/booking_info.dart';
import '../../domain/usecases/load_booking.dart';

part 'booking_bloc.dart';
part 'booking_event.dart';
part 'booking_state.dart';