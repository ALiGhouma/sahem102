import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent { homeView, addReporView, myReports, personalView }

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void navigateToPage(NavigationEvent event) {
    switch (event) {
      case NavigationEvent.homeView:
        emit(0);
        break;
      case NavigationEvent.addReporView:
        emit(1);
        break;
      case NavigationEvent.myReports:
        emit(2);
        break;
      case NavigationEvent.personalView:
        emit(3);
        break;
    }
  }

  NavigationEvent mapIndexToEvent(int index) {
    switch (index) {
      case 0:
        return NavigationEvent.homeView;
      case 1:
        return NavigationEvent.addReporView;
      case 2:
        return NavigationEvent.myReports;
      case 3:
        return NavigationEvent.personalView;
      default:
        throw Exception('Invalid index');
    }
  }
}
