-- =====================================================================
-- Task: Bank
-- =====================================================================
--
-- A bank has exactly 1 boss, exactly 5 managers, and infinitely many
-- workers. Everyone has a name and a wage. Every worker belongs to
-- exactly one manager; each manager has any number of workers
-- (possibly infinite). Design types so these rules can't be broken.
--
-- Build `myBank` with:
--   * boss "Alice", wage 100
--   * managers "M1" to "M5", wage 50 each
--   * each manager i has infinitely many workers
--     "W<i>-1", "W<i>-2", ... with wage 10
--
-- =====================================================================

-- Your types here


data Slave = Slave
  { slaveName :: String
  , slaveWage :: Int
  }

slave1 = Slave "carl" 1
slave2 = Slave "Lennart" 1
slave3 = Slave "shadi" 1
slave4 = Slave "slave4" 1
slave5 = Slave "slave 5" 1
slave6 = Slave "slave 6" 1


data Manager = Manager
  { managerName :: String
  , managerWage :: Int
  , managerSlaves :: [Slave]
  }

manager1 = Manager "Louise" 100 [slave2]

data Boss = Boss
  { bossName :: String
  , bossWage :: Int
  , bossManagers :: (Manager, Manager, Manager, Manager, Manager)
  }


-- >>> bossName boss1
-- >>> bossWage boss1
-- "allice"
-- 50

-- =====================================================================
-- Tests
-- =====================================================================

