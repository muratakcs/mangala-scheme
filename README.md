# Mangala Scheme Tournament

This repository contains a **Scheme-based Mangala game simulation** framework and a basic tournament runner to compare move-selection strategies.

## 🌟 Objective

Students are expected to implement a **Mangala move selection function** in Scheme, following the provided interface. Their strategies will be automatically evaluated in a round-robin tournament format.

## 📁 Folder Structure

```
mangala-scheme/
├── play-game.scm         ; Game logic and simulation engine
├── run-tournament.scm    ; Runs all matches and prints results
├── student1.scm          ; Example strategy: leftmost non-empty pit
├── student2.scm          ; Example strategy: rightmost non-empty pit
├── student3.scm          ; Example strategy: pit with most stones
└── README.md             ; You are here!
```

## 🚀 How to Use

1. Clone or download this repository.
2. Open your Scheme interpreter (e.g., Racket, MIT Scheme, Chez Scheme).
3. Run the tournament with:

```scheme
(load "run-tournament.scm")
```

This will play all matches between defined strategies and print outcomes like:

```scheme
'(student1 student2 (1 0))
'(student1 student3 (0 1))
'(student2 student3 (0.5 0.5))
```

## 🧑‍💻 Student Instructions: Add Your Own Strategy

1. **Create a new file** in the same folder (e.g., `studentX.scm`).
2. Define a function named like this:

```scheme
(define (choose-move-yourname board player)
  ;; Your move selection logic here
)
```

* You may **only use pure functional constructs.**
* Use `(list-ref board i)` to read the state of any pit or store.
* The board is a list of 14 integers representing the pits and stores:

  * `(0..5)` = player 0's pits
  * `6` = player 0's store
  * `(7..12)` = player 1's pits
  * `13` = player 1's store

3. Edit `run-tournament.scm` and **add your function** to the `players` list:

```scheme
(load "studentX.scm")

(define players
  (list
    (cons 'student1 choose-move-student1)
    (cons 'studentX choose-move-yourname)))
```

## ⏱️ Time Constraint (NEW RULE!)

Each move must be selected in **under 0.05 seconds** of CPU time.
If your function takes longer, it will be disqualified or your score penalized.

This constraint encourages clean, efficient code and discourages brute-force simulations or infinite recursion.

## ⚖️ Evaluation Criteria

| Criterion                        | Points  |
| -------------------------------- | ------- |
| Strategy correctness             | 40      |
| Code readability & structure     | 20      |
| Compliance with interface        | 20      |
| Efficiency (respects time limit) | 20      |
| **Total**                        | **100** |

## 🧠 Hints

* Use `let`, `cond`, `map`, `filter`, `modulo`, and other Scheme functional tools.
* You can simulate stone distribution in a helper function to evaluate options.
* Try to think **strategically** — just being greedy might not always work.

---

Have fun building your Mangala AI! 🎮♟️
