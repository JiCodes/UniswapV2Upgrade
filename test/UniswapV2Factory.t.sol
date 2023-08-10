// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Test, console} from "forge-std/Test.sol";
import {UniswapV2Factory} from "../src/UniswapV2Factory.sol";
import {DeployUniswapV2Factory} from "../script/DeployUniswapV2Factory.s.sol";

contract UniswapV2FactoryTest is Test {
    UniswapV2Factory factory;

    address[2] TEST_ADDRESSES = [
        0x1000000000000000000000000000000000000000,
        0x2000000000000000000000000000000000000000
    ];

    address immutable TOKEN_A = makeAddr("tokenA");
    address immutable TOKEN_B = makeAddr("tokenB");
    address immutable FEE_TO_SETTER = makeAddr("FEE_TO_SETTER");
    address immutable FEE_TO = makeAddr("FEE_TO");

    function setUp() external {
        DeployUniswapV2Factory deployFactory = new DeployUniswapV2Factory();
        factory = deployFactory.run(FEE_TO_SETTER);
    }

    function testFeeToAndFeeToSetter() public {
        assertEq(factory.feeToSetter(), FEE_TO_SETTER); // Assuming OWNER is the feeToSetter
        assertEq(factory.feeTo(), address(0)); // Assuming feeTo is not set
        assertEq(factory.allPairsLength(), 0); // Assuming no pair has been created
    }

    function testCreatePair() public {
        factory.createPair(TEST_ADDRESSES[1], TEST_ADDRESSES[0]);
    }

    function testSetFeeTo() public {
        address other = makeAddr("other");
        (bool success, ) = address(factory).call(
            abi.encodeWithSignature("setFeeTo(address)", other)
        );
        assertFalse(success); // Expecting a revert

        vm.prank(FEE_TO_SETTER);
        factory.setFeeTo(FEE_TO);
        assertEq(factory.feeTo(), FEE_TO);
    }

    function testSetFeeToSetter() public {
        address other = makeAddr("other");
        (bool success, ) = address(factory).call(
            abi.encodeWithSignature("setFeeToSetter(address)", other)
        );
        assertFalse(success); // Expecting a revert

        vm.prank(FEE_TO_SETTER);
        factory.setFeeToSetter(FEE_TO_SETTER);
        assertEq(factory.feeToSetter(), FEE_TO_SETTER);

    }
}
