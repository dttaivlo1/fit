import 'package:health/health.dart';

class HealthFlutter{
  // create a HealthFactory for use in the app
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
// define the types to get

  List<HealthDataPoint> _healthDataList = [];
  Future authorize() async {
    var types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.WATER
    ];
    final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();
    bool? hasPermissions =
    await health.hasPermissions(types, permissions: permissions);
    hasPermissions = false;
    bool authorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
        await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");
      }
    }
    print("Authorization");
  }
  Future<List<HealthDataPoint>> fetchData() async {
    authorize();
    var types = [
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BODY_FAT_PERCENTAGE,
    ];
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));
    // Clear old data points
    _healthDataList.clear();
    try {
      // fetch health data
      List<HealthDataPoint> healthData =
      await health.getHealthDataFromTypes(yesterday, now, types);
      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
    // filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

    // print the results
   _healthDataList.forEach((x) => print(x));
return _healthDataList;
    // update the UI to display the results

  }
  Future<double> fetchWater() async {
    var types = [
      HealthDataType.WATER
    ];
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));
    // Clear old data points
    _healthDataList.clear();
    try {
      // fetch health data
      List<HealthDataPoint> healthData =
      await health.getHealthDataFromTypes(yesterday, now, types);
      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
    // filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
    List temp = [];
 double litter = 0;
    // print the results
    _healthDataList.forEach((x) => litter += double.parse(x.value.toString()));
    return litter*=1000;
    // update the UI to display the results
  }
  Future<List<HealthDataPoint>> fetchFood() async {

    var types = [
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];
    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));
    // Clear old data points
    _healthDataList.clear();
    try {
      // fetch health data
      List<HealthDataPoint> healthData =
      await health.getHealthDataFromTypes(yesterday, now, types);
      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }
    // filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
    // print the results
   // _healthDataList.forEach((x) => print(x));
    double totalSpend = 0;
    _healthDataList.forEach((x) => totalSpend += double.parse(x.value.toString()));
    print(totalSpend.toStringAsFixed(1));
    return _healthDataList;
    // update the UI to display the results
  }
  Future<String> addData(int second) async {
    final now = DateTime.now();
    final earlier = now.subtract(Duration(seconds: second));
    bool success = true;
   try  {
     success &= await health.writeWorkoutData(HealthWorkoutActivityType.BOXING, earlier, now);
     return "Thêm dữ liệu thành công";
   }
catch(error){
     return error.toString();
}

    // Store an Audiogram
    // Uncomment these on iOS - only available on iOS
    // const frequencies = [125.0, 500.0, 1000.0, 2000.0, 4000.0, 8000.0];
    // const leftEarSensitivities = [49.0, 54.0, 89.0, 52.0, 77.0, 35.0];
    // const rightEarSensitivities = [76.0, 66.0, 90.0, 22.0, 85.0, 44.5];

    // success &= await health.writeAudiogram(
    //   frequencies,
    //   leftEarSensitivities,
    //   rightEarSensitivities,
    //   now,
    //   now,
    //   metadata: {
    //     "HKExternalUUID": "uniqueID",
    //     "HKDeviceName": "bluetooth headphone",
    //   },
    // );
  }
  Future<String> addWeight(double weight) async {
    final now = DateTime.now();
    bool success = true;
    try  {
      success &= await health.writeHealthData(weight, HealthDataType.WEIGHT, now, now);
      return "Cập nhật cân nặng thành công";
    }
    catch(error){
      return error.toString();
    }

    // Store an Audiogram
    // Uncomment these on iOS - only available on iOS
    // const frequencies = [125.0, 500.0, 1000.0, 2000.0, 4000.0, 8000.0];
    // const leftEarSensitivities = [49.0, 54.0, 89.0, 52.0, 77.0, 35.0];
    // const rightEarSensitivities = [76.0, 66.0, 90.0, 22.0, 85.0, 44.5];

    // success &= await health.writeAudiogram(
    //   frequencies,
    //   leftEarSensitivities,
    //   rightEarSensitivities,
    //   now,
    //   now,
    //   metadata: {
    //     "HKExternalUUID": "uniqueID",
    //     "HKDeviceName": "bluetooth headphone",
    //   },
    // );
  }
  Future<String> addWater(double water) async {
    final now = DateTime.now();
    bool success = true;
    water = water/ 1000;
    try  {
      success &= await health.writeHealthData(water, HealthDataType.WATER, now, now);
      return "Cập nhật cân nặng thành công";
    }
    catch(error){
      return error.toString();
    }
    // Store an Audiogram
    // Uncomment these on iOS - only available on iOS
    // const frequencies = [125.0, 500.0, 1000.0, 2000.0, 4000.0, 8000.0];
    // const leftEarSensitivities = [49.0, 54.0, 89.0, 52.0, 77.0, 35.0];
    // const rightEarSensitivities = [76.0, 66.0, 90.0, 22.0, 85.0, 44.5];

    // success &= await health.writeAudiogram(
    //   frequencies,
    //   leftEarSensitivities,
    //   rightEarSensitivities,
    //   now,
    //   now,
    //   metadata: {
    //     "HKExternalUUID": "uniqueID",
    //     "HKDeviceName": "bluetooth headphone",
    //   },
    // );
  }
}