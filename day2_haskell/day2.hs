main = do 
  let filePath = "./input.txt"
  rawInput <- readFile filePath
  let input = map lineToTuple . lines $ rawInput

  let horizontal1 = foldl (\acc x -> if fst x == "forward" then acc + snd x else acc) 0 input
  let depth1 = foldl (\acc x -> if fst x == "down" then acc + snd x else if fst x == "up" then acc - snd x else acc) 0 input
  putStr "soln1: "
  print $ horizontal1 * depth1

  let horizontal2 = horizontal1
  let depth2 = calculateDepth2 input 0
  putStr "soln2: "
  print $ horizontal2 * depth2
  return ()

tuplify :: [[Char]] -> ([Char],Int)
tuplify [x,y] = (x, read y :: Int)

lineToTuple :: [Char] -> ([Char], Int)
lineToTuple line = tuplify . words $ line

calculateDepth2 :: [([Char], Int)] -> Int -> Int
calculateDepth2 [] _ = 0
calculateDepth2 (x:xs) aim  
  | fst x == "forward" = aim * snd x + calculateDepth2 xs aim
  | fst x == "down" = calculateDepth2 xs (aim + snd x)
  | fst x == "up" = calculateDepth2 xs (aim - snd x)
  | otherwise = 0
