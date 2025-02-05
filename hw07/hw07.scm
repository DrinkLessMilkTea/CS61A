(define (square n) (* n n))


(define (pow base exp)
  (cond
    ((= exp 0) 1)              ; 任何数的 0 次方为 1
    ((= exp 1) base)           ; 任何数的 1 次方为自身
    ((even? exp)              ; 如果指数为偶数
     (let ((res (pow base (/ exp 2)))) ; 递归计算 base^(exp/2)
       (* res res)))          ; 返回 res^2
    (else                     ; 如果指数为奇数
     (let ((res (pow base (quotient exp 2)))) ; 递归计算 base^(exp//2)
       (* (* res res) base))))) ; 返回 res^2 * base

(define (repeatedly-cube n x)
  (if (zero? n)
      x
      (let ((y (repeatedly-cube (- n 1) x)))
        (* y y y))))

(define (cddr s) (cdr (cdr s)))

(define (cadr s) 
  (car (cdr s))  
)

(define (caddr s) 
  (car (cdr (cdr s)))
  )

