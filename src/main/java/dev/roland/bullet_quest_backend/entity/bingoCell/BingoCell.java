package dev.roland.bullet_quest_backend.entity.bingoCell;

import dev.roland.bullet_quest_backend.entity.bingoBoard.BingoBoard;
import dev.roland.bullet_quest_backend.entity.goal.Goal;
import jakarta.persistence.*;

@Entity
@Table(name = "bingo_cells", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"board_id", "row", "column"})
})
public class BingoCell {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "board_id", nullable = false)
    private BingoBoard board;

    @ManyToOne
    @JoinColumn(name = "goal_id", nullable = false)
    private Goal goal;

    private int row;

    @Column(name = "column")
    private int column;

    private boolean completed;
}
