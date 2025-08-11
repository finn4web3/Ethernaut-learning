// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/13-GatekeeperOne.sol";

contract GatekeeperOneTest is Test   {
    IGateKeeperOne private target;
    Hack private hack;

    function setUp() public {
        target = IGateKeeperOne(0xBDd1F989d7708c546021013666818399731d88E2);
        hack = new Hack();
    }

    function testGas() public {
        // uint256 baseGas = 8191 * 3 ;
        for (uint256 i = 100; i < 8191; i++) {
            try hack.enter(address(target),  i) {
                console.log("gas", i);
                return;
            } catch {}
        }
        revert("all failed");
    }
}