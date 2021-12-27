import Data.Bits

main = do 
  -- Part 1
  -- Split lines in the input file into list of bits
  let filePath = "input.txt"
  contents <- readFile filePath
  let input = map (\x -> map (\y -> read [y] :: Int) x) (lines contents)
  -- Get most frequent bits in each index
  let n = length input
  let frequency = foldl (\acc x -> zipWith (+) acc x) (replicate n 0) input
  let freq_bits = map (\x -> if x >= n `div` 2 then 1 else 0) frequency
  -- Calculate gamma and epsilon
  let gamma = btod freq_bits
  let epsilon = btod (map (xor 1) freq_bits)
  putStr "soln1: "
  print (gamma * epsilon)

  -- Part 2
  let o2 = getO2 0 input
  let co2 = getCO2 0 input
  putStr "soln2: "
  print (co2 * o2)
  return ()

toNumList :: String -> [Int]
toNumList arr = map (\x -> read [x] :: Int) arr

-- Binary to decimal
btod :: [Int] -> Int
btod arr = foldl (\acc x -> acc * 2 + x) 0 arr

-- Get most frequent bit in `arr` at index `bit`
mfb bit arr = if (foldl (\acc x -> acc + x !! bit) 0 arr) > ((length arr) `div` 2)
                then 1
              else 0

filterMostFreqBit arr bit
  | (even n) && (ones == n `div` 2) = filter (\x -> x !! bit == 1) arr
  | otherwise = filter (\x -> x !! bit == mfb bit arr) arr
  where ones = (foldl (\acc x -> zipWith (+) acc x) (replicate (length (arr !! 0)) 0) arr) !! bit
        n = length arr

filterLeastFreqBit arr bit
  | (even n) && (ones == n `div` 2) = filter (\x -> x !! bit == 0) arr
  | otherwise = filter (\x -> x !! bit == (mfb bit arr `xor` 1)) arr
  where ones = (foldl (\acc x -> zipWith (+) acc x) (replicate (length (arr !! 0)) 0) arr) !! bit
        n = length arr

getO2 :: Int -> [[Int]] -> Int
getO2 bit arr 
  | length arr == 1 = btod (arr !! 0)
  | bit == (length (arr !! 0)) = btod (arr !! 0)
  | otherwise = getO2 (bit + 1) (filterMostFreqBit arr bit)

getCO2 :: Int -> [[Int]] -> Int
getCO2 bit arr 
  | length arr == 1 = btod (arr !! 0)
  | bit == (length (arr !! 0)) = btod (arr !! 0)
  | otherwise = getCO2 (bit + 1) (filterLeastFreqBit arr bit)