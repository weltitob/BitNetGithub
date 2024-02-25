class Outputs {
  final Map<String, int> outputs;

  Outputs({required this.outputs});

  // Methode zur Erzeugung einer Outputs-Instanz aus einem JSON-Objekt
  factory Outputs.fromJson(Map<String, dynamic> json) {
    // Konvertiert jeden Wert im Map zu int, da JSON-Map-Werte dynamic sind
    var outputs = json.map((key, value) => MapEntry(key, value is int ? value : int.parse(value.toString())));
    return Outputs(outputs: outputs);
  }

  // Methode zur Umwandlung einer Outputs-Instanz in ein JSON-Objekt
  Map<String, dynamic> toJson() {
    // Keine Konvertierung erforderlich, da die Werte bereits int sind und JSON-Keys immer Strings
    return this.outputs;
  }
}
