// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AdvancedERC20 is ERC20, Ownable {
    mapping(address => bool) public blacklist;

    constructor() ERC20("PowerToken", "PWR") Ownable(msg.sender) {
        _mint(msg.sender, 500000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function setBlacklist(address account, bool status) external onlyOwner {
        blacklist[account] = status;
    }

    function _update(address from, address to, uint256 amount) internal override {
        require(!blacklist[from] && !blacklist[to], "Blacklisted");
        super._update(from, to, amount);
    }
}
