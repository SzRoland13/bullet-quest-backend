package dev.roland.bullet_quest_backend.entity.user;

import dev.roland.bullet_quest_backend.entity.bingoBoard.BingoBoard;
import dev.roland.bullet_quest_backend.entity.goal.Goal;
import dev.roland.bullet_quest_backend.entity.tag.Tag;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(name = "registered_at")
    private LocalDateTime registeredAt;

    @Column(name = "email_verified_at")
    private LocalDateTime emailVerifiedAt;

    private String role;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Goal> goals = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Tag> tags = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BingoBoard> bingoBoards = new ArrayList<>();
}
