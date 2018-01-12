{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}
module Flatten where

class Flatten i o where
  flatten :: [i] -> [o]

instance {-# OVERLAPPABLE #-} Flatten a a where
  flatten = id

instance {-# OVERLAPS #-} Flatten i o => Flatten [i] o where
  flatten = concatMap flatten
