(defclass binary-array ()
  ((max-size :reader max-size :initarg :max-size :initform 100)
   (fp :accessor fp :initform 0)
   (insert-before :reader insert-before :initarg :insert-before
		  :initform t)
   (array :accessor array)))

(defun binary-find (target item &optional key-fn)
  (let* ((the-array (array (pairs target)))
	 (fp (fill-pointer the-array)))
    (labels
	((insert-at-loc (loc)
	   (incf (fill-pointer the-array))
	   
	 

(defclass b*tree-node ()
  ((top-value :accessor top-value :initarg :top-value)
   (id :accessor id :initarg :id)
   (previous :accessor previous :initarg :previous)
   (next :accessor next :initarg :next)
   (is-leave :reader is-leave :initarg :is-leave :initform t)
   (parent :accessor parent :initarg :parent)
   (pairs :accessor pairs :initarg :pairs)))

(defun split-list (lst)
  (let ((div (floor (/ (length lst) 2))))
    (if (or (null lst) (zerop div))
	(list lst ())
	(list (subseq lst 0 div) (subseq lst div)))))

(defun b*tree-parent (node)
  (if not (parent node)
      (let ((a-parent 
	    (make-instance
	     'b*tree-node
	     :top-value (top-value node)
	     :is-leave nil
	     :pairs (list node))))
	(b*tree-insert parent node)))
  (node parent))

(defun b*tree-split (node)
  (let ((left-data)
	(right-data)
	(the-parent (btree-ensure-parent node)))
    (multi-value-bind (left-data right-data) (split-list (pairs node)))
    (setf (pairs node) right-data)
    (let ((right
	    (make-instance 'b*tree-node
			   :parent (parent node)
			   :previous (previous node)
			   :next node
			   :pairs left-data)))
      (setf (previous node) right)
      (self (pairs the-parent)
	    (cons right (pairs the-parent))))))

(defun b+tree-insert-pair (target val item)
  (binsert
(defmethod b+tree-instert (target val (item b*tree-node)))
  
(defclass redis-collection (DatabaseCollection))

(defmethod coll-get (collection oid)
  (let ((raw (red:hget collection oid)))
    (json-unstring raw)))

(defmethod Coll-find-ids (collection criteria)
  (coll-find (collection criteria '("id"))))

