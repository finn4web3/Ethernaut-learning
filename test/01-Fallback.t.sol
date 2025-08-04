// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
// import {Fallback} from "../src/01-Fallback.sol";

contract FallbackTest is Script {
    fallback() external payable {
        console.log("Fallback function called");
    }

    receive() external payable {
        console.log("Receive function called");
    }

}

contract Exp is Script {
    function run() external {
        vm.startBroadcast();
        FallbackTest fallbackTest = new FallbackTest();
        // ...existing code...
        (bool success1, ) = payable(address(fallbackTest)).call{value: 1 wei}("");
        require(success1, "First call failed");
        console.log("**********************************");
        (bool success2, ) = payable(address(fallbackTest)).call{value: 2 wei}(hex"22222222");
        require(success2, "Second call failed");
        // ...existing code...
        vm.stopBroadcast();
    }
}