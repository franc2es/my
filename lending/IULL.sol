// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IULL {
    function deposit(address asset, uint256 amount, address from) external;
    function withdraw(address asset, uint256 amount, address to) external;
}
