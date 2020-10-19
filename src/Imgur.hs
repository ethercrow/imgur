{-# language OverloadedStrings #-}
{-# language DataKinds #-}
module Imgur
  ( post
  )
where

import Control.Lens
import qualified Data.Text as T
import qualified Network.HTTP.Client.MultipartFormData as LM
import Network.HTTP.Req
import Text.XML
import Text.XML.Lens

endpoint :: Url 'Https
endpoint = https "api.imgur.com" /: "3" /: "image.xml"

headers :: Option 'Https
headers = header "Authorization" "Client-ID c9a6efb3d7932fd"

post :: FilePath -> IO T.Text
post imagePath = do
  resp <-
    runReq defaultHttpConfig $ do
      body <- reqBodyMultipart [LM.partFileSource "image" imagePath]
      req POST endpoint body lbsResponse headers
  let document = parseLBS_ def $ responseBody resp
  case document ^? root . el "data" ... el "link" . text of
    Just path -> pure path
    _ -> error ("Failed to parse imgur response " <> show document)

-- <?xml version=\\\"1.0\\\" encoding=\\\"utf-8\\\"?>
-- <data type=\\\"array\\\" success=\\\"1\\\" status=\\\"200\\\">
-- <id>2p0uC3f</id>
-- <title/>
-- <description/>
-- <datetime>1562347046</datetime>
-- <type>image/png</type>
-- <animated>false</animated>
-- <width>13</width>
-- <height>13</height>
-- <size>1858</size>
-- <views>0</views>
-- <bandwidth>0</bandwidth>
-- <vote/>
-- <favorite>false</favorite>
-- <nsfw/>
-- <section/>
-- <account_url/>
-- <account_id>0</account_id>
-- <is_ad>false</is_ad>
-- <in_most_viral>false</in_most_viral>
-- <has_sound>false</has_sound>
-- <tags/>
-- <ad_type>0</ad_type>
-- <ad_url/>
-- <edited>0</edited>
-- <in_gallery>false</in_gallery>
-- <deletehash>AAAAAAAAAAAA</deletehash>
-- <name/>
-- <link>https://i.imgur.com/AAAAAAA.png</link>
-- </data>
