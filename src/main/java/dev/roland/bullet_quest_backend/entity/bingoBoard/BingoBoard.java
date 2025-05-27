package dev.roland.bullet_quest_backend.entity.bingoBoard;

import dev.roland.bullet_quest_backend.entity.bingoCell.BingoCell;
import dev.roland.bullet_quest_backend.entity.user.User;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "bingo_boards")
public class BingoBoard {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private int size;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "board", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BingoCell> cells = new ArrayList<>();
}
