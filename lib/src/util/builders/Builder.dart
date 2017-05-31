part of tetris;

abstract class Builder<T>{
  final Reader _reader;

  Builder(Reader reader):_reader = reader{}

  T build(String id);
}