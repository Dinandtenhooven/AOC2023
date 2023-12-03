(defvar *char-list* '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\. #\Newline #\Return))
(defvar *dict* (list))
(defvar sum 0)

(defclass combination ()
  ((key :accessor key
        :initarg :key
        :initform ""
        :type string)
   (nums :accessor nums
         :initarg :nums
         :initform '())))

(defvar *combinations* nil)

(defun getKey (x y)
  (format nil "~d-~d" x y))

(defun numberOfDigits (digit)
  (cond 
    ((< digit 10) 1)
    (t (1+ (numberOfDigits (truncate digit 10))))))

(defun addCoordinate (line y)
  (let ((x 0))
    (loop for c across line
          do (if (char= c #\*)
                 (push (make-instance 'combination
                                      :key (getKey x y)
                                      :nums '())
                       *combinations*)
                 (setq x (1+ x))))))

(defun read-file-line-by-line (file-path)
  (let ((y 0))
    (with-open-file (stream file-path :direction :input)
      (loop for line = (read-line stream nil)
            while line
            do (addCoordinate line y)
               (setq y (1+ y))))))

(defun isChar (x y)
  (let ((key (format nil "~d-~d" x y)))
    (if (eq 1 1)
        t
        nil)))

(defun addToCoordinateList (x y currentNum)
  (dolist (comb *combinations*)
    (when (string= (getKey x y) (key comb))
      (if (not (= 0 currentNum))
        (push currentNum (nums comb))))))

(defun findCharacterInSurroundings (currentNum x y)
  (let ((initY (- y 1))
        (initX (- x (numberOfDigits currentNum) 1))
        (found 0))
    (loop for coorX from initX to (+ initX (numberOfDigits currentNum) 1)
          do (if (and (isChar coorX initY) (eq found 0))
                 (addToCoordinateList coorX initY currentNum)
                 (setq found 1)))

    (loop for coorX from initX to (+ initX (numberOfDigits currentNum) 1)
          do (if (and (isChar coorX (+ initY 2)) (eq found 0))
                 (addToCoordinateList coorX (+ initY 2) currentNum)
                 (setq found 1)))

    (if (and (isChar initX (+ initY 1)) (eq found 0))
        (addToCoordinateList initX (+ initY 1) currentNum)
        (setq found 1))

    (if (and (isChar (+ initX (numberOfDigits currentNum) 1) (+ initY 1)) (eq found 0))
        (addToCoordinateList (+ initX (numberOfDigits currentNum) 1) (+ initY 1) currentNum)
        (setq found 1))))

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

(defun print-combination (comb)
  (format t "Key: ~a, Nums: ~a~%" (key comb) (nums comb)))

(defvar cnt 0)

;; Example usage to print combinations
(loop for combination in *combinations*
      do (let ((number-of-elements (length (nums combination))))
           (if (eq number-of-elements 2)
               (progn
                 (print-combination combination)
                 (let ((a (nth 0 (nums combination)))
                       (b (nth 1 (nums combination))))
                   (setq sum (+ sum (* a b)))
                   (setq cnt (1+ cnt)))))
           ))

(loop for combination in *combinations*
  do (print-combination combination))

(print cnt)
(print sum)



