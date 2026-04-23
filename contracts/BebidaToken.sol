// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BebidaToken {

    address public owner;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    // Solo el owner puede crear tokens
    function mint(address to, uint amount) public {
        require(msg.sender == owner, "Solo el owner puede mintear");
        balances[to] += amount;
    }

    // Transferencia de tokens
    function transferFrom(address from, address to, uint amount) public {
        require(balances[from] >= amount, "Saldo insuficiente");
        balances[from] -= amount;
        balances[to] += amount;
    }

    // Consultar saldo (view)
    function balanceOf(address account) public view returns (uint) {
        return balances[account];
    }
}