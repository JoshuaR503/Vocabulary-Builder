class WordData {
  final String word;
  final String wordPronuntiation;

  final String firstPerson;
  final String secondPerson;
  final String thirdPerson;

  final String firstPersonPlural;
  final String secondPersonPlural;
  final String thirdPersonPlural;

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
    this.word,
    this.wordPronuntiation,
    
    this.firstPerson,
    this.secondPerson,
    this.thirdPerson,

    this.firstPersonPlural,
    this.secondPersonPlural,
    this.thirdPersonPlural,

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
      word: json['word'],
      wordPronuntiation: json['wordPronuntiation'],

      firstPerson: json['firstPerson'],
      secondPerson: json['secondPerson'],
      thirdPerson: json['thirdPerson'],

      firstPersonPlural: json['firstPersonPlural'],
      secondPersonPlural: json['secondPersonPlural'],
      thirdPersonPlural: json['thirdPersonPlural'],

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

  Map<String, dynamic> toJson() => <String, dynamic>{
    'word': word,
    'wordPronuntiation': wordPronuntiation,

    'firstPerson': firstPerson,
    'secondPerson': secondPerson,
    'thirdPerson': thirdPerson,

    'firstPersonPlural': firstPersonPlural,
    'secondPersonPlural': secondPersonPlural,
    'thirdPersonPlural': thirdPersonPlural,

    'past': past,
    'root': root,
    'present': present,

    'synonyms': synonyms,
    'antonyms': antonyms,
    'examples': examples,

    'note': note,
    'category': category,
    'definition': definition
  };

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'wordPronuntiation': wordPronuntiation,

      'firstPerson': firstPerson,
      'secondPerson': secondPerson,
      'thirdPerson': thirdPerson,

      'firstPersonPlural': firstPersonPlural,
      'secondPersonPlural': secondPersonPlural,
      'thirdPersonPlural': thirdPersonPlural,

      'past': past,
      'root': root,
      'present': present,

      'synonyms': synonyms,
      'antonyms': antonyms,

      'examples': examples,
      'note': note,
      'category': category,
      'definition': definition,
    };
  }

  static WordData fromMap(Map<String, dynamic> map) {
    return WordData(
      word: map['word'],
      wordPronuntiation: map['wordPronuntiation'],

      firstPerson: map['firstPerson'],
      secondPerson: map['secondPerson'],
      thirdPerson: map['thirdPerson'],

      firstPersonPlural: map['firstPersonPlural'],
      secondPersonPlural: map['secondPersonPlural'],
      thirdPersonPlural: map['thirdPersonPlural'],

      past: map['past'],
      root: map['root'],
      present: map['present'],

      synonyms: map['synonyms'],
      antonyms: map['antonyms'],

      examples: map['examples'],
      note: map['note'],
      category: map['category'],
      definition: map['definition'],
    );
  }

}
