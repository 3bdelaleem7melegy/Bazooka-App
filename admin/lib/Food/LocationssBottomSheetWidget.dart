import 'package:flutter/material.dart';
import 'package:admin/Food/ViewsModel.dart';

class LocationssBottomSheetWidget extends StatefulWidget {
  ViewModell viewModell;
  LocationssBottomSheetWidget({required this.viewModell , super.key});

  @override
  State<LocationssBottomSheetWidget> createState() => _LocationsBottomSheetWidgetState();
}

class _LocationsBottomSheetWidgetState extends State<LocationssBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(
                          widget.viewModell.allDatas[index]["location"]
                      )),
                      Checkbox(

                        value: widget.viewModell.isDoctorsSelected(widget.viewModell.allDatas[index]),
                        onChanged: (value) {
                          if(value ?? false){
                            widget.viewModell.addDoctors(widget.viewModell.allDatas[index]);
                          }else {
                            widget.viewModell.removeDoctors(widget.viewModell.allDatas[index]);
                          }
                          setState(() {

                          });
                        },
                      ),
                    ],
                  ),
                ),
                itemCount: widget.viewModell.allDatas.length,
              )
          ),
          ElevatedButton(
              onPressed: (){
                widget.viewModell.updateSelectedDoctorssList();
              }, child: const Text("Done"))
        ],
      ),
    );
  }
}
