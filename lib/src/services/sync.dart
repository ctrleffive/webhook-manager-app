import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';

import 'package:webhook_manager/src/services/incoming.dart';
import 'package:webhook_manager/src/services/streams.dart';
import 'package:webhook_manager/src/services/outgoing.dart';
import 'package:webhook_manager/src/services/notification.dart';

class SyncService {
  final NotificationService _notificationService = NotificationService();
  final OutgoingService _outgoingService = OutgoingService();
  final IncomingService _incomingService = IncomingService();

  Future<void> init() async {
    try {
      StreamsService.syncState.sink.add(true);
      final List<NotificationData> allNotifications = await this._notificationService.all;
      StreamsService.notifications.sink.add(allNotifications);
      
      final List<OutgoingData> allOutgoings = await this._outgoingService.all;
      StreamsService.outgoings.sink.add(allOutgoings);
      
      final List<IncomingData> allIncomings = await this._incomingService.all;
      StreamsService.incomings.sink.add(allIncomings);
    } catch (e) {
      rethrow;
    } finally {
      StreamsService.syncState.sink.add(false);
    }
  }
}