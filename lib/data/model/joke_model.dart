class JokeModel {
  String joke;

  JokeModel({required this.joke});

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      joke: json['joke'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['joke'] = joke;
    return data;
  }

  @override
  String toString() {
    return 'JokeModel{joke: $joke}';
  }
}
