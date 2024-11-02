

import 'dart:async';

import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/usecase/usecase.dart';
import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/feature/booking/data/models/main_model.dart';
import 'package:doktor_randevu/feature/booking/data/models/provider_model.dart';
import 'package:doktor_randevu/feature/login/data/models/login_form.dart';
import 'package:doktor_randevu/feature/login/data/models/login_model.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/provider_fetching.dart';
import 'package:doktor_randevu/feature/login/domain/usecases/token_fetching.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../core/widgets/page_status.dart';

part 'login_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';