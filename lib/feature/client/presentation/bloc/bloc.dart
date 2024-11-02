
import 'dart:async';

import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/core/util/local_storage.dart';
import 'package:doktor_randevu/feature/client/data/models/client_model.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_creating.dart';
import 'package:doktor_randevu/feature/client/domain/usecases/client_fetching.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/page_status.dart';

part 'client_bloc.dart';
part 'client_event.dart';
part 'client_state.dart';