// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PuestoConcierto {

    struct Bebida {
        string nombre;
        uint precio;
    }

    mapping(uint => Bebida) public bebidas;
    uint public contador;

    BebidaToken public token;
    
    constructor(address tokenAddress) {
        token = BebidaToken(tokenAddress);
    }

    function agregarBebida(string memory _nombre, uint _precio) public {
        bebidas[contador] = Bebida(_nombre, _precio);
        contador++;
    }

    function comprar(uint id) public {
        Bebida memory bebida = bebidas[id];

        // llamada a otro contrato
        token.transfer(address(this), bebida.precio);
    }

    function verBebida(uint id) public view returns (Bebida memory) {
        return bebidas[id];
    }
}