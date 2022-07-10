// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract PixelWars {

    mapping(uint8 => uint256) public pixels;

    constructor() {}

    function paint(uint8 x, uint8 y, bool color) external payable {
        require(msg.value == cost, "Invalid transaction cost");
        if (color) {
            pixels[y] |= 2 ** x;
        } else {
            pixels[y] &= ~(2 ** x);
        }
    }

}
