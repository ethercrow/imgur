# imgur

[![CircleCI](https://circleci.com/gh/ethercrow/imgur.svg?style=svg)](https://circleci.com/gh/ethercrow/imgur)

A function to post an image to imgur

## How to use it

```haskell
import Imgur (post)

main = do
    image_url <- post "broccoli.png"
    print image_url
```
