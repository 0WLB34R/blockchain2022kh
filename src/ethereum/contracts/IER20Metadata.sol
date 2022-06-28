// SPDX-Licence-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface ERC20Metadata {
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function decimals() external view returns(uint8);
}