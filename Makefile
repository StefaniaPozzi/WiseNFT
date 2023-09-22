include .env 

.PHONY: push, interaction

push:
	git add .
	git commit -m "added HappyNFT, test base64"
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
	forge script script/HappyNFTDeploy.s.sol:HappyNFTDeploy --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY) --private-key $(PRIVATE_KEY_METAMASK) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) -vvvv

deploy-anvil:
	forge script script/HappyNFTDeploy.s.sol:HappyNFTDeploy --rpc-url $(RPC_URL_ANVIL)  --private-key $(PRIVATE_KEY_ANVIL) --gas-limit 4700000 --broadcast -vvvv

mint-sepolia:
	forge script script/Interactions.s.sol:MintProgrammatically --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY) --private-key $(PRIVATE_KEY_METAMASK) --broadcast --verify --etherscan-api-key $(API_KEY_ETHERSCAN) -vvvv

test-sepolia:
	forge test --rpc-url $(RPC_URL_SEPOLIA_ALCHEMY)

convert-svg-base64:
	base64 -i img/guineaPig2.svg

mint-happy:
	cast send 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 "mintToken()" --rpc-url $(RPC_URL_ANVIL)  --private-key $(PRIVATE_KEY_ANVIL) 

flip-mood: 	
	cast send 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 "flipMood(uint256)" 0 --private-key ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://127.0.0.1:8545



