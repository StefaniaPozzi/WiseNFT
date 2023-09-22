//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {HappyNFTDeploy} from "../../script/HappyNFTDeploy.s.sol";
import {HappyNFT} from "../../src/HappyNFT.sol";

contract HappyNFTIntergrationTest is Test {
    HappyNFTDeploy deployer;
    HappyNFT happyNFT;
    address private USER_A = makeAddr("alice");

    function setUp() public {
        deployer = new HappyNFTDeploy();
        happyNFT = deployer.run();
    }

    function testFlip() public {
        vm.prank(USER_A);
        happyNFT.mintToken();

        vm.prank(USER_A);
        happyNFT.flipMood(0);

        assertEq(
            keccak256(abi.encodePacked(happyNFT.imageURI(0))),
            keccak256(abi.encodePacked(deployer.getHappierSvgURI()))
        );
    }
}
