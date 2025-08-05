#!/bin/bash
for i in {1..10}
do
  echo "⏳ 第 $i 次调用flip()..."
    forge script script/03-CoinFlip.sol:CoinFlipSolution --rpc-url $RPC_URL --broadcast -vv   
  echo "✅ 等待新块...60s"
  sleep 10
done
