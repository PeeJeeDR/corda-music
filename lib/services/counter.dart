import 'package:rxdart/subjects.dart';

class CounterService {
  final BehaviorSubject _counter = BehaviorSubject.seeded(0);

  Stream get stream$ => _counter.stream;

  int get current => _counter.value;

  inrement() {
    _counter.add(current + 1);
  }
}
