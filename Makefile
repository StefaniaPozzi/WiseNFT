include .env 

.PHONY: push, interaction

push:
	git add .
	git commit -m "init"
	git push origin master

interaction-sepolia:
	forge script script/Interactions.s.sol:$(INTERACTION) --private-key $(PRIVATE_KEY_METAMASK) --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY) --broadcast

test-fork:
	forge test --mt testPerformUpkeepRunsWhenCheckUpkeepIsTrue --fork-url $(RPC_URL_SEPOLIA_ALCHEMY)  -vvvv

install:
	forge install OpenZeppelin/openzeppelin-contracts --no-commit

dependencies:
	   brew install jq

install-all:
	forge install Cyfrin/foundry-devops@0.0.11 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install transmissions11/solmate@v6 --no-commit

deploy-sepolia:
	forge script script/WiseNFTDeploy.s.sol:WiseNFTDeploy --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY) --private-key $(PRIVATE_KEY_METAMASK) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) -vvvv

mint-sepolia:
	forge script script/Interactions.s.sol:MintProgrammatically --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY) --private-key $(PRIVATE_KEY_METAMASK) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) -vvvv

convert-svg-base64:
	base64 -i img/guineaPig2.svg
