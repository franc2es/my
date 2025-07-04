// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ULLVault.sol";

contract LendingPool {
    ReserveVault public vault;

    constructor(address _vault) {
        vault = ReserveVault(_vault);
    }
    function deposit(address asset, uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        ull.deposit(asset, msg.sender, amount);
    }
