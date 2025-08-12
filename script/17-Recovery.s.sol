// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/17-Recovery.sol";


contract Dev {
    function recover(address sender) external pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), sender, bytes1(0x01)));
        address addr = address(uint160(uint256(hash)));
        return addr;
    }
}

contract RecoverySolution is Script {
    address sender = 0x3431DBA9fd88fbFfD91287d41081C27E94760B5F;
    Dev dev = new Dev();
    address simpleTokenAddress = dev.recover(sender);

    SimpleToken simpleTokenInstance = SimpleToken(payable(simpleTokenAddress));
    
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        simpleTokenInstance.destroy(payable(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}