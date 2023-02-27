import 'package:core/core_export.dart';
import 'package:flutter/foundation.dart';

class PictureGridState {
  const PictureGridState({
    this.uiState = PictureGridUIState.initial,
    this.pictures = const [],
    this.search = '',
    this.existsMoreDataInSearch = false,
    this.uiEvent = PictureGridUIEvent.initial,
    this.selectedPicture = const Picture(),
  });
  final PictureGridUIState uiState;
  final PictureGridUIEvent uiEvent;
  final List<Picture> pictures;
  final Picture selectedPicture;
  final String search;
  final bool existsMoreDataInSearch;

  PictureGridState copyWith({
    PictureGridUIState? uiState,
    PictureGridUIEvent? uiEvent,
    List<Picture>? pictures,
    Picture? selectedPicture,
    String? search,
    bool? existsMoreDataInSearch,
  }) {
    return PictureGridState(
      uiState: uiState ?? this.uiState,
      uiEvent: uiEvent ?? this.uiEvent,
      pictures: pictures ?? this.pictures,
      selectedPicture: selectedPicture ?? this.selectedPicture,
      search: search ?? this.search,
      existsMoreDataInSearch:
          existsMoreDataInSearch ?? this.existsMoreDataInSearch,
    );
  }

  @override
  bool operator ==(covariant PictureGridState other) {
    if (identical(this, other)) return true;
  
    return 
      other.uiState == uiState &&
      other.uiEvent == uiEvent &&
      listEquals(other.pictures, pictures) &&
      other.selectedPicture == selectedPicture &&
      other.search == search &&
      other.existsMoreDataInSearch == existsMoreDataInSearch;
  }

  @override
  int get hashCode {
    return uiState.hashCode ^
      uiEvent.hashCode ^
      pictures.hashCode ^
      selectedPicture.hashCode ^
      search.hashCode ^
      existsMoreDataInSearch.hashCode;
  }
}

enum PictureGridUIState {
  initial,
  loading,
  empty,
  error,
  success,
}

enum PictureGridUIEvent {
  goToDetails,
  initial,
}
