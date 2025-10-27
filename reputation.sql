-- Reputation System Database
-- Created for FiveM

CREATE TABLE IF NOT EXISTS `reputation_data` (
  `identifier` varchar(100) NOT NULL,
  `trust_factor` int(11) NOT NULL DEFAULT 500,
  `level_name` varchar(50) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Indexes for better performance
CREATE INDEX IF NOT EXISTS `idx_trust_factor` ON `reputation_data` (`trust_factor` DESC);
CREATE INDEX IF NOT EXISTS `idx_last_update` ON `reputation_data` (`last_update` DESC);

-- Insert default data (optional)
-- This will set default trust factor for new players

