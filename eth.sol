// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TaxToken is ERC20, Ownable {
    uint256 public constant TAX_RATE = 2;
    address public immutable fund;

    constructor(address _fund) ERC20("MemeKing", "KING") Ownable(msg.sender) {
        fund = _fund;
        _mint(msg.sender, 10000000000 * 10 ** decimals());
    }


    function _update(address from, address to, uint256 amount) internal override {
        if (from != address(0) && to != address(0)) {
            uint256 tax = amount * TAX_RATE / 100;
            uint256 burnAmt = tax / 2;
            uint256 fundAmt = tax - burnAmt;

            super._update(from, fund, fundAmt);
            super._burn(from, burnAmt);
            amount -= tax;
        }
        super._update(from, to, amount);
    }
}
