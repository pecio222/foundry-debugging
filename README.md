This is very simple repository, that should help debugging transactions on Trader Joe platform (or any other, really).


To start, you should have installed:

- git https://github.com/git-guides/install-git
- Foundry https://book.getfoundry.sh/getting-started/installation
- any IDE, or simple text editor

To start, open your terminal, navigate to directory you want to clone this repository to.
In your terminal:

```shell
$ git clone https://github.com/pecio222/foundry-debugging.git
$ cd foundry-debugging
$ forge build
```

This should download all scripts, compile them and make them ready to use.

To use scripts, you will need to manually edit some parameters in them (like user, token address etc). During editing, it's helpful to use IDE like Visual Studio Code with extension(s) for Solidity language, that will help by auto-formatting, pointing possible compile errors etc.

```shell
$ forge script script/test_swap.s.sol 
$ forge script script/any_tx.s.sol
```

Other helpful commands, that get onto your computer when having Foundry installed:

Re-run any transaction. Usually better and more insightful against Snowtrace.
```shell
$ cast run 0xa41038e0884380b67c6c8854e63323550f779d47af49fc28fedcbc5925921021 --rpc-url https://api.avax.network/ext/bc/C/rpc
```

Call any function on any contract (even unverified). Example: balance of WAVAX (will return value in wei)
```shell
$ cast call 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7 "balanceOf(address)(uint256)" 0x6d80113e533a2C0fe82EaBD35f1875DcEA89Ea97 --rpc-url https://api.avax.network/ext/bc/C/rpc


```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
