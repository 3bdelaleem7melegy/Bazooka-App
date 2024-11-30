
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewModell extends ChangeNotifier {

  List<Map<String, dynamic>> datas = [];
  List<Map<String, dynamic>> allDatas = [];
  List<Map<String, dynamic>> selectedDoctorss = [];
  List<Map<String, dynamic>> selectedLocationss = [];
  String? errorMessages;

  Future<void> loadData() async {
    datas = [];
    errorMessages = null;
    notifyListeners();
    try {
      allDatas = await FirebaseFirestore.instance
          .collection("Dentist")
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      datas = copyList(allDatas);
      notifyListeners();
    } catch (e) {
      errorMessages = e.toString();
      notifyListeners();
    }
  }

  List<Map<String , dynamic>> copyList(List<Map<String , dynamic>> originalLists){
    List<Map<String , dynamic>> copy = [];
    for(int i = 0; i< originalLists.length ; i++){
      copy.add(originalLists[i]);
    }
    return copy;
  }

  void addDoctors(Map<String,dynamic> doctors){
    selectedDoctorss.add(doctors);
    notifyListeners();
  }
  void addLocations(Map<String,dynamic> doctors){
    selectedLocationss.add(doctors);
    notifyListeners();
  }

  void removeDoctors(Map<String,dynamic> doctors){
    for(int i = 0; i<selectedDoctorss.length ; i++){
      if(doctors["id"] == selectedDoctorss[i]["id"]){
        selectedDoctorss.removeAt(i);
      }
    }
    notifyListeners();
  }

  void updateSelectedDoctorssList(){
    if(selectedDoctorss.isNotEmpty){
      datas = copyList(selectedDoctorss);
    }else {
      datas = copyList(allDatas);
    }
    notifyListeners();
  }

  bool isDoctorsSelected(Map<String,dynamic> doctors){
    for(int i = 0 ; i < selectedDoctorss.length ; i++){
      if(doctors["id"] == selectedDoctorss[i]["id"]){
        return true;
      }
    }
    return false;
  }

}
