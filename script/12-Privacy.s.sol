// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/12-Privacy.sol";

contract PrivacySolution is Script {

    Privacy privacyInstance = Privacy(0x36967e4B200e051511337713D26A39266b4E28F5);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes16 key = 0x12f0fc959d4d218bd2b6c1a2d0cca3ae;
        
        console.log("Before: ", privacyInstance.locked());
        privacyInstance.unlock(key);
        console.log("After: ", privacyInstance.locked());
        
        vm.stopBroadcast();
    }
}

