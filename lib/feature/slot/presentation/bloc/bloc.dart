
import 'dart:async';

import 'package:doktor_randevu/core/network/api_response.dart';
import 'package:doktor_randevu/feature/slot/data/models/slot_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/page_status.dart';
import '../../domain/usecases/load_slot.dart';

part 'slot_bloc.dart';
part 'slot_event.dart';
part 'slot_state.dart';