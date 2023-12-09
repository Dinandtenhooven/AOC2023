import Data.Maybe
import Data.List
import Data.Text (Text)
import qualified Data.Text as Tx
import System.IO
import qualified Distribution.Compat.CharParsing as Char

maybeToInt :: Maybe Int -> Int
maybeToInt (Just n) = n
maybeToInt Nothing  = 0

findCharIndex :: Char -> String -> Maybe Int
findCharIndex char str = elemIndex char str

substr :: Int -> Int -> Text -> Text
substr start length = Tx.take length . Tx.drop start

isNewline :: Char -> Bool
isNewline c = c == '\n'

splitWords :: String -> [String]
splitWords s = case dropWhile isNewline s of
    "" -> []
    s' -> w : splitWords s''
        where (w, s'') = break isNewline s'

mapTriples :: [String] -> [(String, String, String)]
mapTriples strs = map (\x -> (
    Tx.unpack (substr 0 3 (Tx.pack x)),
    Tx.unpack (substr 7 3 (Tx.pack x)),
    Tx.unpack (substr 12 3 (Tx.pack x))
    )) strs

findTuples :: Eq a => a -> [(a, b, c)] -> (a, b, c)
findTuples y tuples = filter (\(x, _, _) -> x == y) tuples

getLeft :: (String, String, String) -> String
getLeft (_, s, _) = s

getRight :: (String, String, String) -> String
getRight (_, _, s) = s

main :: IO ()
main = do
    -- Open the file in ReadMode
    handle <- openFile "example.txt" ReadMode
    contents <- hGetContents handle
    
    let found = findCharIndex '\n' contents
    let index = maybeToInt found

    let leftRights = substr 0 index (Tx.pack contents)
    let mappingstring = substr (index+1) 10000 (Tx.pack contents)
    
    let words = splitWords (Tx.unpack mappingstring)
    let triples = mapTriples words

    let count = 0
    let word = "AAA"

    mapM_ (\x -> do 
        let triple = findTuples word triples
        if x == 'L' 
            then let word = getLeft triple
            else if x == 'R' then let word = getRight triple

        -- if word = "ZZZ" then 

        putStrLn word
        ) (Tx.unpack leftRights)
    
    
    
    


    let 

    hClose handle
