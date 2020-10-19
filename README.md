# imgur

[![GitHub CI](https://github.com/ethercrow/imgur/workflows/CI/badge.svg)](https://github.com/ethercrow/imgur/actions)
[![Hackage](https://img.shields.io/hackage/v/imgur.svg?logo=haskell)](https://hackage.haskell.org/package/imgur)
[![Stackage Lts](http://stackage.org/package/imgur/badge/lts)](http://stackage.org/lts/package/imgur)
[![Stackage Nightly](http://stackage.org/package/imgur/badge/nightly)](http://stackage.org/nightly/package/imgur)

A function to post an image to imgur

## How to use it

```haskell
import Imgur (post)

main = do
    image_url <- post "broccoli.png"
    print image_url
```
