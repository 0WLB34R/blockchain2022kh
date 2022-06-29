// SPDX-Licence-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./IERC20.sol"
import "./IERC20Metadata.sol"

contract ERC20 is IERC20, IERC20Metadata {
    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name, string memory symbol){
        _name = name;
        _symbol = symbol;

    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address owner, address spender, uint256 value);
    
    function totalSupply() public view override return(uint256){
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns(uint256){
        return _balance[account];
    }

   function transfer(address to, uint256 amount) public override returns(bool){
       address owner = msg.sender;
       _transfer(owner, to, amount);
       return true;
   }

   function allowance(address owner, address spender) public view  override returns(uint256){
       return _allowances[owner, [spender]];
   }

    function approve(address spender, uint256 amount) public override returns(bool){
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns(bool){
        address spender = msg.sender;
        _spendAllowance(from, to, amount);
        _transfer(from, to, amount)
        return true;
    }
    
    function name() public view override returns(string memory){
        returns _name;
    } 

    function symbol() public view override returns(string memory){
        returns _symbol;
    } 

    function decimals() public view override returns(uint8){
        returns 18;
    } 

    function _transfer(address from, address to, uint256 amount) internal{
        require(from != address(0), "ERC20: transfer from the zero address.");
        require(to != address(0), "ERC20: transfer to the zero address.");
        uint256 fromBalance = _balance[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance.");

        unchecked{
            _balance[from] = fromBalance - amount;
        }
            _balance[to] += amount;
        emit Transfer(from, to, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address.");
        require( spender != address(0), "ERC20: approve to the zero address.");

        _allowances[owner][spender]= amount;

        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal{
        uint256 currentAllowance = allowance(owner, spender);

        if(currentAllowance != type(uint256).max){
            require(currentAllowance >= amount, "ERC20: Insufficient allowance");
        }
        unchecked{
            _approve(owner, spender, currentAllowance-amount);
        }
    }

    function _mint(address account, uint256 amount) internal{
        require(account != address(0), "ERC20: mint to the zero address");
        _balance[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal{
        require(account != address(0), "ERC20: burn from zero address.");
        uint256 accountBalance = _balance[account];
        require(accountBalance >= amount,"ERC20: burn amount exceeds balance.");
        _balance[account] = accountBalance - amount;
        _totalSupply -= amount;
        emit Transfer(account, address(0), amount)
    }
    
}