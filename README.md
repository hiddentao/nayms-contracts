TODO...

## Dev

In separate terminal run local private chain:

```
docker run -it --rm -p 8545:8501 0xorg/devnet
```

In current terminal, first run setup script:

```
yarn setup
```

Now deploy contracts to local chain:

```
yarn deploy:local
```
