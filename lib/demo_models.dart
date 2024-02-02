class DemoAppointmentModel {
  int? id;
  String? title;
  String? place;
  String? date;
  String? image;
  String? type;
  int? invetations;
  int? approve;

  DemoAppointmentModel({
    this.id,
    this.title,
    this.place,
    this.date,
    this.image,
    this.type,
    this.invetations,
  });
}

List<DemoAppointmentModel> demoAppointmentList = [
  DemoAppointmentModel(
    id: 1,
    title: 'حجز البيك',
    place: 'الرياض',
    date: '2:00am 22/10/12',
    image: 'assets/images/avatar_person.jpg',
    type: 'date',
    invetations: 3,
  ),
  DemoAppointmentModel(
    id: 1,
    title: 'حجز عيادة الاسنان',
    place: 'الرياض',
    date: '2:00am 22/10/12',
    image: 'assets/images/avatar_person.jpg',
    type: 'date',
    invetations: 0,
  ),
  DemoAppointmentModel(
    id: 1,
    title: 'دعوة -منزل خالد',
    place: 'الرياض',
    date: '2:00am 22/10/12',
    image: 'assets/images/avatar_person.jpg',
    type: 'event',
    invetations: 3,
  ),
];
