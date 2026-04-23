// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import del otro contrato
import "./BebidaToken.sol";

contract PuestoConcierto {

    address public owner;
    BebidaToken public token;

    constructor(address tokenAddress) {
        owner = msg.sender;
        token = BebidaToken(tokenAddress);
    }

    // Struct (requisito)
    struct Bebida {
        string nombre;
        uint precio;
        uint stock;
    }

    // Mapping (requisito)
    mapping(uint => Bebida) public bebidas;
    uint public contador;

    // Evento (extra para mejorar nota)
    event Compra(address comprador, string bebida);

    // Solo owner puede añadir bebidas
    function agregarBebida(string memory _nombre, uint _precio, uint _stock) public {
        require(msg.sender == owner, "Solo el owner puede agregar");

        bebidas[contador] = Bebida(_nombre, _precio, _stock);
        contador++;
    }

    // Comprar bebida (llamada a otro contrato) + Concepto de storage
    function comprar(uint id) public {
        Bebida storage bebida = bebidas[id];

        require(bebida.stock > 0, "Sin stock");

        // Transferimos tokens del comprador al contrato
        token.transferFrom(msg.sender, address(this), bebida.precio);

        bebida.stock--;

        emit Compra(msg.sender, bebida.nombre);
    }

    // Ver bebida (view + memory)
    function verBebida(uint id) public view returns (string memory, uint, uint) {
        Bebida memory b = bebidas[id];
        return (b.nombre, b.precio, b.stock);
    }

    // Ver saldo del usuario
    function verMiSaldo() public view returns (uint) {
        return token.balanceOf(msg.sender);
    }
}