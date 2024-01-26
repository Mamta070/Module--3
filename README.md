# Module--3
# *Mint, Burn & Transfer*

This is a Solidity smart contract for create your own ERC20 token and deploy it using HardHat or Remix. Once deployed, you should be able to interact with it for your walk-through video. From your chosen tool, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens

## *Introduction*

The peoject allows to mint, burn and transfer the amount of tokens also we can give allowance to the reciver address to spend some token 

### *Requirements*

- [*Solidity*](https://soliditylang.org/) (>= 0.8.9)
- Ethereum development environment

## *Functions*

'function mint(address account, uint256 amount) external onlyOwner'
this function will mint token for us

'function burn(uint256 amount) external onlyOwner'
this function will burn token for us

' function transferWithCheck(address to, uint256 amount) external'
this function will tranfer tokens for us 


## *Authors*
 Mamta Chintalwar
