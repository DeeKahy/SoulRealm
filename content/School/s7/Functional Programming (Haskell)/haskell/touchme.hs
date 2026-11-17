runme :: (Num t1) => t1 -> t2
runme x = runme (x + 1)

-- >>> runme 10
