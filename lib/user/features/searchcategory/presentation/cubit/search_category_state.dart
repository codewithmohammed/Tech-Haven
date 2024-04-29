import 'package:equatable/equatable.dart';

class SearchCategoryCubitState extends Equatable {
  final int currentIndex;
  final int? openedAccordionIndex;
  final int? pageOfcurrentAccordionIndex;

  const SearchCategoryCubitState(this.currentIndex, this.openedAccordionIndex, this.pageOfcurrentAccordionIndex);

  @override
  List<Object?> get props => [currentIndex, openedAccordionIndex, pageOfcurrentAccordionIndex];
}
