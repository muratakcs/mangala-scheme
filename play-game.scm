(define (init-board)
  ;; 6 pits + 1 store for each player
  (list 4 4 4 4 4 4 0  4 4 4 4 4 4 0))

(define (opponent player) (if (= player 0) 1 0))

(define (player-range player)
  (if (= player 0) '(0 1 2 3 4 5) '(7 8 9 10 11 12)))

(define (store-index player) (if (= player 0) 6 13))

(define (valid-move? board pit player)
  (and (member pit (player-range player)) (> (list-ref board pit) 0)))

(define (distribute board pit player)
  (let* ((stones (list-ref board pit))
         (new-board (list-set board pit 0)))
    (define (distribute-helper b idx s)
      (if (= s 0) b
          (let* ((next (modulo (+ idx 1) 14))
                 (skip? (and (= next (store-index (opponent player)))))
                 (target (if skip? (modulo (+ next 1) 14) next)))
            (distribute-helper
              (list-set b target (+ 1 (list-ref b target)))
              target (- s 1)))))
    (distribute-helper new-board pit stones)))

(define (make-move board pit player)
  (if (valid-move? board pit player)
      (distribute board pit player)
      board))

;; Zaman ölçüm fonksiyonu
(define (timed-choose choose-fn board player)
  (define t0 (current-process-milliseconds))
  (define move (choose-fn board player))
  (define t1 (current-process-milliseconds))
  (define duration (/ (- t1 t0) 1000.0))
  (if (> duration 0.05)
      (begin
        (display "⚠️  WARNING: Move took too long: ") (display duration) (display "s\\n"))
      (void))
  move)

;; Oyun döngüsü
(define (play-game choose-A choose-B)
  (define (loop board player)
    (if (or (null? (filter (lambda (i) (> (list-ref board i) 0)) (player-range 0)))
            (null? (filter (lambda (i) (> (list-ref board i) 0)) (player-range 1))))
        board
        (let* ((choose (if (= player 0) choose-A choose-B))
               (move (timed-choose choose board player)))
          (begin
            (display "Player ") (display player)
            (display " chooses pit ") (display move) (newline)
            (define new-board (make-move board move player))
            (display "Board after move: ") (display new-board) (newline)
            (loop new-board (opponent player))))))
  (loop (init-board) 0))
