// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Transfer_20 is IERC20 {
    string private _Tok_name;
    string private _Tok_symbol;
    address private _Contract_owner;
    mapping(address => uint256) private _balances;
    uint256 private _Total_Supply = 1000;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    modifier onlyOwner {
        require(msg.sender == _Contract_owner, "Only owner is allowed to perform this operation");
        _;
    }

    constructor(string memory T_name, string memory T_symbol) {
        _Tok_name = T_name;
        _Tok_symbol = T_symbol;  
        _Contract_owner = msg.sender;
        _balances[_Contract_owner] = _Total_Supply;
        emit Mint(_Contract_owner, _Total_Supply);
    }

    function totalSupply() external view override returns (uint256) {
        return _Total_Supply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        require(to != address(0), "InvalidReceiver: transfer to the zero address");
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= value, "InsufficientBalance: insufficient balance for transfer");

        _balances[sender] -= value;
        _balances[to] += value;

        emit Transfer(sender, to, value);
        return true;
    }

    function burn(uint256 value) public returns (bool) {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= value, "InsufficientBalance: insufficient balance for burn");

        _balances[sender] -= value;
        _Total_Supply -= value;

        emit Burn(sender, value);
        return true;
    }

    function mint(address to, uint256 value) public onlyOwner returns (bool) {
        _balances[to] += value;
        _Total_Supply += value;

        emit Mint(to, value);
        emit Transfer(address(0), to, value);
        return true;
    }

    function allowance(address owner, address receiver) external view override returns (uint256) {
        return _allowances[owner][receiver];
    }

    function approve(address receiver, uint256 value) external override returns (bool) {
        address owner = msg.sender;
        uint256 ownerBalance = _balances[owner];
        require(receiver != address(0), "InvalidReceiver: approve to the zero address");
        require(ownerBalance >= value, "InsufficientBalance: insufficient balance for approval");

        _allowances[owner][receiver] = value;

        emit Approval(owner, receiver, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        address receiver = msg.sender;
        uint256 allowanceBalance = _allowances[from][receiver];
        require(to != address(0), "InvalidReceiver: transfer to the zero address");
        require(allowanceBalance >= value, "InsufficientAllowance: insufficient allowance for transfer");

        _allowances[from][receiver] -= value;
        _balances[to] += value;

        emit Transfer(from, to, value);
        return true;
    }

    error InvalidReceiver(address _to);
    error InsufficientBalance(address from, uint256 fromBalance, uint256 value);
    error InsufficientAllowance(address receiver , address from, uint256 currentAllowance, uint256 value);
}
