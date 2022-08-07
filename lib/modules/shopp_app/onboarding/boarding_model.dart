class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Boarding title 1',
      body: 'boarding body 1'),
  BoardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Boarding title 2',
      body: 'boarding body 2'),
  BoardingModel(
      image: 'assets/images/onboarding_4.jpg',
      title: 'Boarding title 3',
      body: 'boarding body 3'),
];
