// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract BebidaToken {
    address public owner;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    function mint(address to, uint amount) public {
        require(msg.sender == owner, "Solo el owner puede crear tokens");
        balances[to] += amount;
    }

    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount, "Saldo insuficiente");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}