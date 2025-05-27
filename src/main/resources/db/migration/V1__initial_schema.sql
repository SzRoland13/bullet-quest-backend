-- ENUMs
CREATE TYPE user_role AS ENUM ('USER', 'ADMIN');
CREATE TYPE goal_difficulty AS ENUM ('LOW', 'MEDIUM', 'HIGH');
CREATE TYPE goal_status AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED');

-- Users
CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       email VARCHAR(255) NOT NULL UNIQUE,
                       username VARCHAR(100) NOT NULL UNIQUE,
                       password TEXT NOT NULL,
                       registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       email_verified_at TIMESTAMP,
                       role user_role DEFAULT 'USER',
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Goals
CREATE TABLE goals (
                       id BIGSERIAL PRIMARY KEY,
                       user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                       title VARCHAR(255) NOT NULL,
                       description TEXT,
                       difficulty goal_difficulty DEFAULT 'LOW',
                       reward TEXT,
                       status goal_status DEFAULT 'NOT_STARTED',
                       deadline DATE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       completed_at TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tags
CREATE TABLE tags (
                      id BIGSERIAL PRIMARY KEY,
                      user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                      name VARCHAR(100) NOT NULL,
                      UNIQUE(user_id, name),
                      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Goal-Tag mapping (many-to-many)
CREATE TABLE goal_tag (
                          goal_id BIGINT NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
                          tag_id BIGINT NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
                          PRIMARY KEY(goal_id, tag_id)
);

-- Bingo boards
CREATE TABLE bingo_boards (
                              id BIGSERIAL PRIMARY KEY,
                              user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                              name VARCHAR(100) NOT NULL,
                              size INTEGER NOT NULL CHECK (size > 0),
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bingo cells
CREATE TABLE bingo_cells (
                             id BIGSERIAL PRIMARY KEY,
                             board_id BIGINT NOT NULL REFERENCES bingo_boards(id) ON DELETE CASCADE,
                             goal_id BIGINT NOT NULL REFERENCES goals(id) ON DELETE CASCADE,
                             row INTEGER NOT NULL,
                             "column" INTEGER NOT NULL,
                             completed BOOLEAN DEFAULT FALSE,
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             UNIQUE(board_id, row, "column")
);

-- Indexes for performance
CREATE INDEX idx_goals_user_id ON goals(user_id);
CREATE INDEX idx_tags_user_id ON tags(user_id);
CREATE INDEX idx_bingo_boards_user_id ON bingo_boards(user_id);
CREATE INDEX idx_bingo_cells_board_id ON bingo_cells(board_id);
CREATE INDEX idx_bingo_cells_goal_id ON bingo_cells(goal_id);
