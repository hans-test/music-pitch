
{-# LANGUAGE GeneralizedNewtypeDeriving, StandaloneDeriving #-}

------------------------------------------------------------------------------------
-- |
-- Copyright   : (c) Hans Hoglund 2012
--
-- License     : BSD-style
--
-- Maintainer  : hans@hanshoglund.se
-- Stability   : experimental
-- Portability : non-portable (TF,GNTD)
--
-- Provides interval numbers.
--
-------------------------------------------------------------------------------------

module Music.Pitch.Common.Number (
        -- ** Number
        Number,
        HasNumber(..),   
        unison,
        prime,
        second,
        third,
        fourth,
        fifth,
        sixth,
        seventh,
        octave,
        ninth,
        tenth,
        twelfth, 
        duodecim,
        thirteenth,
        fourteenth,
        fifteenth,
        
        -- * Inspecting
        isConsonance,
        isPerfectConsonance,
        isImperfectConsonance,
        isDissonance,
  ) where

-- |
-- The number portion of an interval (i.e. second, third, etc).
--
-- Note that the interval number is always one step larger than number of steps spanned by
-- the interval (i.e. a third spans two diatonic steps). Thus 'number' does not distribute
-- over addition:
--
-- > number (a + b) = number a + number b - 1
--
newtype Number = Number { getNumber :: Integer }
    deriving (Eq, Ord, Num, Enum, Real, Integral)
    
instance Show Number where { show = show . getNumber }
instance HasNumber Number where number = id

unison      :: Number
prime       :: Number
second      :: Number
third       :: Number
fourth      :: Number
fifth       :: Number
sixth       :: Number
seventh     :: Number
octave      :: Number
ninth       :: Number
tenth       :: Number
eleventh    :: Number
twelfth     :: Number
duodecim    :: Number
thirteenth  :: Number
fourteenth  :: Number
fifteenth   :: Number
unison      = 1
prime       = 1
second      = 2
third       = 3
fourth      = 4
fifth       = 5
sixth       = 6
seventh     = 7
octave      = 8
ninth       = 9
tenth       = 10
eleventh    = 11
twelfth     = 12
duodecim    = 12
thirteenth  = 13
fourteenth  = 14
fifteenth   = 15

class HasNumber a where
    -- |
    -- Returns the number portion of an interval.
    --
    -- The interval number is negative if and only if the interval is negative.
    --
    -- See also 'quality', 'octaves' and 'semitones'.
    --
    number :: a -> Number

isConsonance :: HasNumber a => a -> Bool
isConsonance a = isPerfectConsonance a || isImperfectConsonance a

isPerfectConsonance :: HasNumber a => a -> Bool
isPerfectConsonance a = case number a of
    1 -> True
    4 -> True
    5 -> True

isImperfectConsonance :: HasNumber a => a -> Bool
isImperfectConsonance a = case number a of
    3 -> True
    6 -> True

isDissonance :: HasNumber a => a -> Bool
isDissonance a = case number a of
    2 -> True
    7 -> True
