import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../data/model/book.dart';
import '../../data/repository/gutendex.dart';

class BookCubit extends HydratedCubit<BookCubitState> {
  final Gutendex gutendex;
  BookCubit(this.gutendex, {required BookCubitState initialState})
      : super(initialState);

  Future<void> getBooks() async {
    final books = await gutendex.getBooks();
    emit(BookCubitLoadedState(books: books));
  }

  @override
  BookCubitState? fromJson(Map<String, dynamic> json) {
    try {
      return BookCubitLoadedState.fromMap(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(BookCubitState state) {
    if (state is BookCubitLoadedState) {
      return state.toMap();
    }
    return null;
  }
}

class BookCubitState {}

class BookCubitInitialState extends BookCubitState {}

class BookCubitLoadingState extends BookCubitState {}

class BookCubitLoadedState extends BookCubitState {
  final List<Book> books;
  BookCubitLoadedState({required this.books});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'books': books.map((x) => x.toMap()).toList()});
    return result;
  }

  factory BookCubitLoadedState.fromMap(Map<String, dynamic> map) {
    return BookCubitLoadedState(
      books: List<Book>.from(map['books']?.map((x) => Book.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookCubitLoadedState.fromJson(String source) =>
      BookCubitLoadedState.fromMap(json.decode(source));
}
