main = do
  let filePath = "input/input.txt"
  contents <- readFile filePath
  let intList = map (read::String->Int) (lines contents)
  print (increaseCount intList)
  let tripleList = tripleSums intList
  print (increaseCount tripleList)
  return ()

increaseCount :: (Num a, Ord a) => [a] -> a
increaseCount [] = 0
increaseCount [x] = 0
increaseCount (x:xs) = (if x < head xs then 1 else 0) + increaseCount xs

tripleSums :: (Num a, Ord a) => [a] -> [a]
tripleSums (x:y:z:[]) = [x+y+z]
tripleSums (x:y:z:xs) = (x+y+z):(tripleSums (y:z:xs))