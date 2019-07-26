{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}
-------------------------------------------
-- |
-- Module      : Web.Stripe.Account
-- Copyright   : (c) David Johnson, 2014
-- Maintainer  : djohnson.m@gmail.com
-- Stability   : experimental
-- Portability : POSIX
--
-- < https:/\/\stripe.com/docs/api#account >
--
-- @
-- {-\# LANGUAGE OverloadedStrings \#-}
-- import Web.Stripe
-- import Web.Stripe.Account
--
-- main :: IO ()
-- main = do
--   let config = StripeConfig (StripeKey "secret_key")
--   result <- stripe config getAccountDetails
--   case result of
--     Right account    -> print account
--     Left stripeError -> print stripeError
-- @
module Web.Stripe.OAuth
    ( -- * API
      getOAuth
      -- * Types
    ) where

import           Web.Stripe.StripeRequest (Method (POST), StripeHasParam,
                                           StripeRequest (..), StripeReturn,
                                           mkStripeRequest,
                                           mkStripeRequestToHost, toStripeParam)
import           Web.Stripe.Types         (AuthCode (..), OAuth (..),
                                           Scope (..))

------------------------------------------------------------------------------
data GetOAuth
type instance StripeReturn GetOAuth = OAuth
instance StripeHasParam GetOAuth AuthCode
instance StripeHasParam GetOAuth Scope

getOAuth :: AuthCode -> StripeRequest GetOAuth
getOAuth authCode = request
  where request = mkStripeRequestToHost POST "connect.stripe.com" url params
        url     = "oauth/token"
        params  = toStripeParam authCode []
