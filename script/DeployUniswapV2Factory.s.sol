// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {Script} from "forge-std/Script.sol";
import {UniswapV2Factory} from "../src/UniswapV2Factory.sol";

contract DeployUniswapV2Factory is Script {
    function run(address feeToSetter) external returns (UniswapV2Factory) {
        
        vm.startBroadcast();
        UniswapV2Factory uniswapV2Factory = new UniswapV2Factory(feeToSetter);
        vm.stopBroadcast();
        return uniswapV2Factory;
    }
}