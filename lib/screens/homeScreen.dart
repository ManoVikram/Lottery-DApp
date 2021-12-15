import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/smart_contract_linker.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _privateKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final smartContractLinker = context.watch<SmartContractLinker>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottery"),
        centerTitle: true,
        foregroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              // * Text Field For Address
              TextField(
                autofocus: true,
                controller: _addressController,
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 5.0,
                      color: Colors.greenAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2.5,
                      color: Colors.greenAccent,
                    ),
                  ),
                  label: const Text("Your Address"),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // * Text Field For Address' Private Key
              TextField(
                autofocus: true,
                controller: _privateKeyController,
                decoration: InputDecoration(
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 5.0,
                      color: Colors.greenAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 2.5,
                      color: Colors.greenAccent,
                    ),
                  ),
                  label: const Text("Your Address' Private Key"),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              // * Start New Contract Button
              // * Enter Lottery Button
              // * Pick Winner Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ! Commented the below 'Start Lottery' button out as this is not necessary
                  // ! The one who deploys the contract will be the lottery manager
                  /* ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      padding: const EdgeInsets.all(24),
                      primary: Colors.greenAccent,
                      onPrimary: Colors.black,
                      shadowColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text("Start Lottery"),
                  ), */
                  ElevatedButton(
                    onPressed: () {
                      smartContractLinker.enterLottery(
                          _addressController.text.trim(),
                          _privateKeyController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      padding: const EdgeInsets.all(24),
                      primary: Colors.greenAccent,
                      onPrimary: Colors.black,
                      shadowColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text("Enter Lottery"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      smartContractLinker.pickWinner(
                          _addressController.text.trim(),
                          _privateKeyController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10.0,
                      padding: const EdgeInsets.all(24),
                      primary: Colors.greenAccent,
                      onPrimary: Colors.black,
                      shadowColor: Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text("Pick Winner"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
