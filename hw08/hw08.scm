(define (ascending? s) 
    (cond
      ((null? s) #t)
      ((null? (cdr s)) #t)
      ((> (car s) (car (cdr s))) #f)
      (else (ascending? (cdr s)))
      )
  )

(define (my-filter pred s) 
    (cond 
      ((null? s) s)
      ((pred (car s)) (cons (car s) (my-filter pred (cdr s))))
      (else (my-filter pred (cdr s)))
    )
  )

(define (interleave lst1 lst2) 
  (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    (else (append (cons (car lst1) nil) (interleave lst2 (cdr lst1))))
  )
)

(define (no-repeats s) 
  (cond
    ((null? s) s)
    (else (cons (car s) (no-repeats (filter (lambda (x) (not (= x (car s)))) s))) )
  )
)
