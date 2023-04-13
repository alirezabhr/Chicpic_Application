import 'package:equatable/equatable.dart';

class Pagination<T> extends Equatable{
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  const Pagination({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];
}
