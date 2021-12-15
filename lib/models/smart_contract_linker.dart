import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class SmartContractLinker extends ChangeNotifier {
  final String _rpcURL = "http://127.0.0.1:7545";
  final String contractName = "Lottery";
  // final String privateKey = "590a47c1f19fb90a95f4e06d40dbd638f60d27f2eb44103af942c2a89a521376";

  late Client httpClient;
  late Web3Client ethClient;
  late Credentials credentials;
  late EthereumAddress address;
  late String abi;
  late EthereumAddress contractAddress;
  late DeployedContract contract;
  late ContractFunction add, subtract, getNumber;

  SmartContractLinker() {
    httpClient = Client();
    ethClient = Web3Client(_rpcURL, httpClient);
    // initSetup();
    getContract();
  }

  Future<void> initSetup() async {
    await getContract();
  }

  Future<DeployedContract> getContract() async {
    // * Include this ABI string's path in 'assets' in 'pubspec.yaml'
    String abiString =
        await rootBundle.loadString("contracts/build/contracts/Lottery.json");
    var abiJson = jsonDecode(abiString);
    abi = jsonEncode(abiJson["abi"]);

    contractAddress =
        EthereumAddress.fromHex("");

    contract = DeployedContract(
      ContractAbi.fromJson(abi, contractName),
      contractAddress,
    );

    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    contract = await getContract();
    ContractFunction function = contract.function(functionName);
    List<dynamic> result = await ethClient.call(
      contract: contract,
      function: function,
      params: args,
    );

    return result;
  }

  Future<String> transaction(String functionName, List<dynamic> args,
      String address, String privateKey) async {
    credentials = EthPrivateKey.fromHex(privateKey);
    ContractFunction function = contract.function(functionName);
    dynamic result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: args,
        from: EthereumAddress.fromHex(address),
        // ! I don't have to send any ethers as I'm just picking the winner
        // ! and not entering the lottery
        value: functionName == "pickWinner"
            ? null
            : EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
      ),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );

    EtherAmount balance = await ethClient.getBalance(contractAddress);
    print(balance.getInEther);

    return result;
  }

  Future<void> enterLottery(String address, String privateKey) async {
    var result = await transaction(
      "enterLottery",
      [],
      address,
      privateKey,
    );
    print(result);

    notifyListeners();
  }

  Future<void> pickWinner(String address, String privateKey) async {
    var result = await transaction(
      "pickWinner",
      [],
      address,
      privateKey,
    );
    print(result);

    notifyListeners();
  }
}
