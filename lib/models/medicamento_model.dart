class Medicamento {
  String text;
  Future<void> ?audio;

  Medicamento(this.text);

  String get getText {
    return text;
  }
}
