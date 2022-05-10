import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/ui/event/event_item_card.dart';
import 'package:flutter_hackathon/ui/event/event_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/event.dart';

class EventPage extends ConsumerWidget {
  const EventPage({Key? key, required this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventViewModelProvider);
    final notifier = ref.read(eventViewModelProvider.notifier);

    final List<Widget> eventsWidget = state.events
        .whereType<Event>()
        .toList()
        .map((e) => EventItemCard(
            event: e, addFavoriteEvent: notifier.addFavoriteEvent))
        .toList();

    return SingleChildScrollView(
      controller: controller,
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (!state.isLoading)
              Container(
                  color: Colors.orange,
                  width: double.infinity,
                  height: kToolbarHeight,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'images/event_icon.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  )),
            Column(children: eventsWidget),
            const SizedBox(height: 30)
          ],
        ),
        if (state.isLoading)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
      ]),
    );
  }
}
