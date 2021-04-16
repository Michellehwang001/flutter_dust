class AirResult {
  String status;
  Data data;

  AirResult({this.status, this.data});

  AirResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String city;
  String state;
  String country;
  Location location;
  List<Forecasts> forecasts;
  Current current;
  History history;

  Data(
      {this.city,
        this.state,
        this.country,
        this.location,
        this.forecasts,
        this.current,
        this.history});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['forecasts'] != null) {
      forecasts = new List<Forecasts>();
      json['forecasts'].forEach((v) {
        forecasts.add(new Forecasts.fromJson(v));
      });
    }
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : null;
    history =
    json['history'] != null ? new History.fromJson(json['history']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.forecasts != null) {
      data['forecasts'] = this.forecasts.map((v) => v.toJson()).toList();
    }
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history.toJson();
    }
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Forecasts {
  String ts;
  int aqius;
  int aqicn;
  int tp;
  int tpMin;
  int pr;
  int hu;
  int ws;
  int wd;
  String ic;

  Forecasts(
      {this.ts,
        this.aqius,
        this.aqicn,
        this.tp,
        this.tpMin,
        this.pr,
        this.hu,
        this.ws,
        this.wd,
        this.ic});

  Forecasts.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    aqius = json['aqius'];
    aqicn = json['aqicn'];
    tp = json['tp'];
    tpMin = json['tp_min'];
    pr = json['pr'];
    hu = json['hu'];
    ws = json['ws'];
    wd = json['wd'];
    ic = json['ic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['aqius'] = this.aqius;
    data['aqicn'] = this.aqicn;
    data['tp'] = this.tp;
    data['tp_min'] = this.tpMin;
    data['pr'] = this.pr;
    data['hu'] = this.hu;
    data['ws'] = this.ws;
    data['wd'] = this.wd;
    data['ic'] = this.ic;
    return data;
  }
}

class Current {
  Weather weather;
  Pollution pollution;

  Current({this.weather, this.pollution});

  Current.fromJson(Map<String, dynamic> json) {
    weather =
    json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    pollution = json['pollution'] != null
        ? new Pollution.fromJson(json['pollution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    if (this.pollution != null) {
      data['pollution'] = this.pollution.toJson();
    }
    return data;
  }
}

class Weather {
  String ts;
  int tp;
  int pr;
  int hu;
  double ws;
  int wd;
  String ic;

  Weather({this.ts, this.tp, this.pr, this.hu, this.ws, this.wd, this.ic});

  Weather.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    tp = json['tp'];
    pr = json['pr'];
    hu = json['hu'];
    ws = json['ws'];
    wd = json['wd'];
    ic = json['ic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['tp'] = this.tp;
    data['pr'] = this.pr;
    data['hu'] = this.hu;
    data['ws'] = this.ws;
    data['wd'] = this.wd;
    data['ic'] = this.ic;
    return data;
  }
}

class Pollution {
  String ts;
  int aqius;
  String mainus;
  int aqicn;
  String maincn;
  P2 p2;

  Pollution(
      {this.ts, this.aqius, this.mainus, this.aqicn, this.maincn, this.p2});

  Pollution.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    aqius = json['aqius'];
    mainus = json['mainus'];
    aqicn = json['aqicn'];
    maincn = json['maincn'];
    p2 = json['p2'] != null ? new P2.fromJson(json['p2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts'] = this.ts;
    data['aqius'] = this.aqius;
    data['mainus'] = this.mainus;
    data['aqicn'] = this.aqicn;
    data['maincn'] = this.maincn;
    if (this.p2 != null) {
      data['p2'] = this.p2.toJson();
    }
    return data;
  }
}

class P2 {
  double conc;
  int aqius;
  int aqicn;

  P2({this.conc, this.aqius, this.aqicn});

  P2.fromJson(Map<String, dynamic> json) {
    conc = json['conc'];
    aqius = json['aqius'];
    aqicn = json['aqicn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conc'] = this.conc;
    data['aqius'] = this.aqius;
    data['aqicn'] = this.aqicn;
    return data;
  }
}

class History {
  List<Weather> weather;
  List<Pollution> pollution;

  History({this.weather, this.pollution});

  History.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    if (json['pollution'] != null) {
      pollution = new List<Pollution>();
      json['pollution'].forEach((v) {
        pollution.add(new Pollution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.pollution != null) {
      data['pollution'] = this.pollution.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
