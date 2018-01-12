{-# LANGUAGE DataKinds, OverloadedStrings #-}
module Main where

import Flatten (flatten)
import Data.List (intersperse)
import Data.Foldable (for_)
import Data.Singletons (SomeSing(..))
import Control.Monad (forever)
import System.FilePath.Find (find, always, extension, (==?))
import qualified Data.ByteString.Char8 as BS
import qualified Foreign.JNI as J
import Foreign.JNI.Types
import qualified Foreign.JNI.String as S

-- Dependencies

retrieveLibraries :: String -> IO [FilePath]
retrieveLibraries = find always (extension ==? ".jar")

argLibs :: [String] -> [String]
argLibs = intersperse ":"

jvmOptions natives libs = do
    jars <- retrieveLibraries libs
    return ["-Djava.library.path=" ++ natives, "-Djava.class.path=" ++ flatten (argLibs jars)]

jvmOptions' = jvmOptions "natives" "libs"

-- End Dependencies

-- Minecraft


getMain :: IO JClass
getMain = J.findClass $ referenceTypeName (SClass "net/minecraft/client/main/Main")

getMainMethod :: JClass -> IO JMethodID
getMainMethod main = J.getStaticMethodID main (S.fromChars "main") $ methodSignature [SomeSing (SArray (SClass "java/lang/String"))] SVoid

launchMinecraft :: IO ()
launchMinecraft = do
    main <- getMain
    stringClass <- J.findClass $ referenceTypeName $ SClass "java/lang/String"
    arr <- J.newObjectArray 0 stringClass
    method <- getMainMethod main
    J.callStaticVoidMethod main method [ JObject arr ]

main :: IO ()
main = do
    -- Get dependencies
    libs <- jvmOptions'
    J.withJVM (map BS.pack libs) launchMinecraft