
class Address {
  final int id;
  final String name;
  final int areaId;
  final String areaName;
  final String areaNameArabic;
  final int blockId;
  final String blockName;
  final String blockNameArabic;
  final String street;
  final String jedha;
  final int houseNumber;
  final int floorNumber;
  final int apartmentNo;
  final String comments;
  final String nickname;

  Address({
    required this.id,
    required this.name,
    required this.areaId,
    required this.areaName,
    required this.areaNameArabic,
    required this.blockId,
    required this.blockName,
    required this.blockNameArabic,
    required this.jedha,
    required this.comments,
    required this.street,
    required this.houseNumber,
    required this.floorNumber,
    required this.apartmentNo,
    required this.nickname,
  });

  Map toJsonForPatch(String mobile) => {
    'mobile': mobile,
    'address_id': id,
    'name':nickname.trim()==""?"Home":nickname,
    'nickname': nickname.trim()==""?"Home":nickname,
    'jedha': jedha,
    'comments': comments,
    'street': street,
    'house_number': houseNumber==-1?'':houseNumber,
    'floor_number': floorNumber==-1?'':floorNumber,
    'apartment_no': apartmentNo==-1?'':apartmentNo,

    'area_id': areaId,
    'block_id': blockId,
  };
  Map toJsonForPost(String mobile) => {
    'mobile': mobile,
    'name': nickname.trim()==""?"Home":nickname,
    'jedha': jedha,
    'nickname': nickname.trim()==""?"Home":nickname,

    'comments': comments,
    'street': street,
    'house_number': houseNumber==-1?'':houseNumber,
    'floor_number': floorNumber==-1?'':floorNumber,
    'apartment_no': apartmentNo==-1?'':apartmentNo,
    'area_id': areaId,
    'block_id': blockId,
  };
}

Address mapAddress(dynamic payload) {
  return Address(
    id: (payload["id"] != null && payload["id"] != false)
        ? payload["id"]
        : -1,
    name: (payload["name"]!= null && payload["name"] != false)?payload["name"] : "",
    comments:
    ( payload["comments"] != null && payload["comments"] != false) ? payload["comments"].toString() : "",
    nickname:
    ( payload["name"] != null && payload["name"] != false) ? payload["name"].toString() : "",
    jedha:( payload["jedha"] != null && payload["jedha"] != false)? payload["jedha"].toString() : "",
    street: (payload["street"] != null && payload["street"] != false)? payload["street"].toString() : "",

    areaId: payload["area_id"] ?? -1,
    areaName:
    payload["area_name"] != null && payload["area_name"] != false
        ? payload["area_name"].toString() : "",
    areaNameArabic: payload["area_name_arabic"] != null && payload["area_name_arabic"] != false
        ? payload["area_name_arabic"].toString()
        : "",
    blockId: payload["block_id"] ?? -1,
    blockNameArabic: payload["block_name_arabic"] != null && payload["block_name_arabic"] != false
        ? payload["block_name_arabic"].toString()
        : "",
    blockName: payload["block_name"] != null && payload["block_name"] != false
        ? payload["block_name"].toString()
        : "",

    floorNumber: payload["floor_number"] != null
        ? payload["floor_number"] != ""? int.parse(payload["floor_number"].toString())
        :-1 : -1,
    houseNumber: payload["house_number"] != null
        ? payload["house_number"] != ""? int.parse(payload["house_number"].toString())
        :-1 : -1,
    apartmentNo: payload["apartment_no"] != null
        ? payload["apartment_no"] != ""? int.parse(payload["apartment_no"].toString())
        :-1 : -1,


  );
}
