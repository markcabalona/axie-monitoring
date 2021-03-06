import 'dart:developer';
import 'package:axie_monitoring/models/player.dart' as models;
import 'package:axie_monitoring/providers/driftuserprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlayer extends StatelessWidget {
  AddPlayer({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _percentageCtrl = TextEditingController();
  final TextEditingController _roninAddressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  //name
                  controller: _nameCtrl,
                  validator: (val) => _validateName(val),
                ),
                TextFormField(
                  //percentage
                  controller: _percentageCtrl,
                  validator: (val) => _validatePercentage(val),
                ),
                TextFormField(
                  //ronin address
                  controller: _roninAddressCtrl,
                  validator: (val) => _validateRoninAddress(
                    val,
                    Provider.of<PlayersProvider>(context,listen: false).players,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        Provider.of<PlayersProvider>(context, listen: false)
                            .addPlayer(
                          models.Player(
                            name: _nameCtrl.text,
                            percentage:
                                double.parse(_percentageCtrl.text) / 100,
                            roninId: _roninAddressCtrl.text
                                .replaceFirst('ronin:', '0x'),
                          ),
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Scholar ${_nameCtrl.text} added."),
                          ),
                        );
                      } catch (e) {
                        log(e.toString());
                      }
                    }
                  },
                  child: const Text("Add Scholar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateName(String? val) {
    if (val!.isEmpty) {
      return "This field cannot be empty.";
    } else if (val.length > 32) {
      return "Too long.";
    }
    return null;
  }

  String? _validatePercentage(String? val) {
    if (val != null) {
      try {
        double _percentage = double.parse(val);
        if (!(_percentage >= 0 && _percentage <= 100)) {
          return "Percentage must be between 0 and 100.";
        }
        return null;
      } catch (e) {
        log(e.toString());
        return "Percentage must be in decimal.";
      }
    }
    return "This field cannot be empty.";
  }

  String? _validateRoninAddress(String? val, List<models.Player> players) {
    if (val!.isNotEmpty) {
      if (!(val.contains('ronin:'))) {
        return "Invalid Ronin Address.";
      } else if (players
          .map((player) => player.roninId)
          .toList()
          .contains(val.replaceFirst('ronin:', '0x'))) {
        return "Player is already in the list.";
      } else {
        return null;
      }
    }
    return "This field cannot be empty.";
  }
}
