(defvar *char-list* '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\. #\Newline #\Return))
(defvar *dict* (list))
(defvar sum 0)

(defun numberOfDigits (digit)
     (cond 
          ((< digit 10) 1)
          (t (1+ (numberOfDigits (truncate digit 10))))
      ))

(defun addCoordinate (line y)
  (let ((x 0))
    (loop for c across line
          do (if (eq NIL (member c *char-list*))
               (push (format nil "~d-~d" x y) *dict*))
          (setq x (1+ x)))))

(defun read-file-line-by-line (file-path)
  (let ((y 0))
    (with-open-file (stream file-path :direction :input)
      (loop for line = (read-line stream nil)
            while line
            do (addCoordinate line y)
            (setq y (1+ y))))))

(defun isChar (x y)
  (let ((key (format nil "~d-~d" x y)))
    (print key)
    (if (find (getKey x y) *dict* :test #'string=)
        (return-from isChar t)
        (return-from isChar nil))))

(defun getKey(x y)
  (format nil "~d-~d" x y))

(defun findCharacterInSurroundings(currentNum x y)
  (let ((initY (- y 1))
        (initX (- x (numberOfDigits currentNum) 1))
        (found 0))
    (loop for coorX from initX to (+ initX (numberOfDigits currentNum) 1)
          do (if (isChar coorX initY)
                 (setq found 1)))
    (loop for coorX from initX to (+ initX (numberOfDigits currentNum) 1)
          do (if (isChar coorX (+ initY 2))
                 (setq found 1)))
    (if (isChar initX (+ initY 1))
        (setq found 1))
    (if (isChar (+ initX (numberOfDigits currentNum) 1) (+ initY 1))
        (setq found 1))
    (if (= found 1)
        (setq sum (+ sum currentNum)))

    (print sum)))

(defun read-file-line-by-line2 (file-path)
  (let ((y 0))
    (with-open-file (stream file-path :direction :input)
      (loop for line = (read-line stream nil)
            while line
            do
            (let ((isNum 0))
              (let ((currentNum 0))
                (let ((x 0))
                  (loop for c across line
                        do
                        (if (digit-char-p c)
                            (setq currentNum (+ (* currentNum 10) (digit-char-p c)))
                            (progn
                              (findCharacterInSurroundings currentNum x y)
                              (setq currentNum 0)))
                        (setq x (1+ x))))))
            (setq y (1+ y))))))


;; Example usage

(read-file-line-by-line "input1.txt")
(read-file-line-by-line2 "input1.txt")

;; (defun print-list-values (my-list)
;;   (dolist (value my-list)
;;     (print value)))

;; Example usage
;; (print-list-values *dict*)

;; (print (find (getKey 3 1) *dict* :test #'string=))
;; (print (find (getKey 3 2) *dict* :test #'string=))