//SPDX License-Identifier:MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {WiseNFTDeploy} from "../../script/WiseNFTDeploy.s.sol";
import {WiseNFT} from "../../src/WiseNFT.sol";

contract WiseNFTTest is Test {
    WiseNFTDeploy public deployer;
    WiseNFT public wise;
    address public USER_A = makeAddr("alice");
    string public constant GUINEA_PIG_1_JSON_URI =
        "ipfs://bafybeifaw42cxz324ixzcwm7v6nhpyvb373e6cgs4nlhea6jisbi6cn6qy/?filename=guineaPig1.json";

    function setUp() public {
        deployer = new WiseNFTDeploy();
        wise = deployer.run();
    }

    function testName() public view {
        string memory expectedName = "Wisy"; //array of bytes
        string memory actualName = wise.name();
        //compare hashes
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testMintsAndHasBalance() public {
        vm.prank(USER_A);
        wise.mintToken(GUINEA_PIG_1_JSON_URI);
        assert(wise.balanceOf(USER_A) == 1);
        assert(keccak256(abi.encodePacked(wise.tokenURI(0))) == keccak256(abi.encodePacked(GUINEA_PIG_1_JSON_URI)));
    }
}
