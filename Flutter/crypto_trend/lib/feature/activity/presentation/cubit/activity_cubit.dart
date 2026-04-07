import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/repository/AppRepository.dart';
import 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final AppRepository repository;

  ActivityCubit({required this.repository}) : super(ActivityInitial());

  Future<void> fetchActivities() async {
    emit(ActivityLoading());
    try {
      final data = await repository.getUserActivity();

      List<Map<String, dynamic>> mappedActivities = data.map((order) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(order['time']);
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);

        bool isBuy = order['side'] == 'BUY';
        String typeLabel = order['type'] == 'LIMIT' ? 'L' : 'M';
        String sideLabel = isBuy ? 'B' : 'S';

        return {
          'type': '$typeLabel/$sideLabel',
          'isBuy': isBuy,
          'symbol': order['symbol'].toString().replaceFirst(RegExp(r'(BUSD|USDT)$'), r'/$1'),
          'date': formattedDate,
          'amount': '${order['executedQty']}/${order['origQty']}',
          'price': order['price'].toString(),
          'status': order['status'].toString().substring(0, 1).toUpperCase() + 
                    order['status'].toString().substring(1).toLowerCase(),
        };
      }).toList();

      emit(ActivityLoaded(mappedActivities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }
}