class WordData {
  final String firstPerson;
  final String secondPerson;
  final String thirdPerson;

  final String past;
  final String root;
  final String present;

  final String synonyms;
  final String antonyms;

  final String examples;
  final String note;
  final String category;
  final String definition;

  const WordData({
    this.firstPerson,
    this.secondPerson,
    this.thirdPerson,

    this.past,
    this.root,
    this.present,

    this.synonyms,
    this.antonyms,

    this.examples,
    this.note,
    this.category,
    this.definition
  });

  factory WordData.fromJson(Map<String, dynamic> json){
    return WordData(
      firstPerson: json['firstPerson'],
      secondPerson: json['secondPerson'],
      thirdPerson: json['thirdPerson'],

      past: json['past'],
      root: json['root'],
      present: json['present'],

      synonyms: json['synonyms'],
      antonyms: json['antonyms'],

      examples: json['examples'],
      note: json['note'],
      category: json['category'],
      definition: json['definition'],
    );
  }

}
