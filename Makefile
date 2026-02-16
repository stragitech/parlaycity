# ParlayCity Development Makefile

# -- Local Development --
chain:
	cd packages/contracts && anvil

deploy-local:
	cd packages/contracts && forge script script/Deploy.s.sol --broadcast --rpc-url http://127.0.0.1:8545

dev-web:
	cd apps/web && pnpm dev

dev-services:
	cd packages/services && pnpm dev

# -- Testing --
test-contracts:
	cd packages/contracts && forge test -vvv

test-services:
	cd packages/services && pnpm test

test-all: test-contracts test-services

# -- Quality Gate --
gate: test-all typecheck build-web

typecheck:
	cd apps/web && npx tsc --noEmit

build-web:
	cd apps/web && pnpm build

build-contracts:
	cd packages/contracts && forge build

coverage:
	cd packages/contracts && forge coverage --report summary

snapshot:
	cd packages/contracts && forge snapshot

# -- Cleanup --
clean:
	cd packages/contracts && forge clean
	cd apps/web && rm -rf .next

.PHONY: chain deploy-local dev-web dev-services test-contracts test-services test-all gate typecheck build-web build-contracts coverage snapshot clean
