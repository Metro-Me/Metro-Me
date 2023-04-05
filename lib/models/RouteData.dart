class Route {
  int? stations;
  String? from;
  String? to;
  FromStationStatus? fromStationStatus;
  FromStationStatus? toStationStatus;
  String? totalTime;
  int? fare;
  List<Route>? route;
  String? message;

  Route(
      {this.stations,
      this.from,
      this.to,
      this.fromStationStatus,
      this.toStationStatus,
      this.totalTime,
      this.fare,
      this.route,
      this.message});

  Route.fromJson(Map<String, dynamic> json) {
    stations = json['stations'];
    from = json['from'];
    to = json['to'];
    fromStationStatus = json['from_station_status'] != null
        ? new FromStationStatus.fromJson(json['from_station_status'])
        : null;
    toStationStatus = json['to_station_status'] != null
        ? new FromStationStatus.fromJson(json['to_station_status'])
        : null;
    totalTime = json['total_time'];
    fare = json['fare'];
    if (json['route'] != null) {
      route = <Route>[];
      json['route'].forEach((v) {
        route!.add(new Route.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stations'] = this.stations;
    data['from'] = this.from;
    data['to'] = this.to;
    if (this.fromStationStatus != null) {
      data['from_station_status'] = this.fromStationStatus!.toJson();
    }
    if (this.toStationStatus != null) {
      data['to_station_status'] = this.toStationStatus!.toJson();
    }
    data['total_time'] = this.totalTime;
    data['fare'] = this.fare;
    if (this.route != null) {
      data['route'] = this.route!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class FromStationStatus {
  String? status;
  String? title;
  String? note;

  FromStationStatus({this.status, this.title, this.note});

  FromStationStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['title'] = this.title;
    data['note'] = this.note;
    return data;
  }
}
