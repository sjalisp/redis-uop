;;;; redis-uop.lisp

(in-package #:redis-uop)


(defun get-class (cls-id)
  (red:hget "classes" cls-id))

(defun get-classes ()
  (red:hvals "classes"))

(defun meta-by-id (kind id)
  (red:hget kind id))

(defun meta-get-all (kind)
  (red:hvals kind))

(defun metadata ()
  '(:classes (meta-get-all "classes")
    :attributes (meta-get-all "attributes")
    :groups (meta-get-all "groups")
    :tags (meta-get-all "tags")
    :roles (meta-get-all "roles")
    :queries (meta-get-all "queries")))

(defun define-meta (name &keys description id superclass attrs sys-defined app-defined mutable)
  '(:name name :id (or id (make-id)) :superclass superclass :attrs attrs :sys-defined sys-defined
    :app-defined app-defined :mutable mutable))
 
(defclass MetaObject ()
  ((_id :accessor :id :initform (make-meta-id))
   (name :accessor name :initarg :name)
   (description :accessor description :initarg :description)
   (sys-defined :accessor sys-defined :initarg :sys-defined :initform nil)
   (app-defined :accessor app-defined :initarg :app-defined :initform nil)
   (mutable :accessor mutuable :initarg :mutable :initform 't)))

(defclass MetaClass (MetaObject)
  ((superclass :accessor superclass :initarg :superclass)
   (attrs :accessor attrs :initarg :attrs)
   (instance-collection :accessor instances :initarg :instances)))

(defun  get-object (object-id)
  (let ((cls-id (class-id object-id)))
    (red:hget cls-id object-id)))

(defclass MetaAttribute (MetaObject)
  ((valueMutable :accessor valueMutable :initarg :valueMutable :initform 't)
   (default-value :accessor default-value :initarg :default-value)
   (attribute-type :accessor attribute-type :initarg :attribute-type)))

(defclass MetaRole (MetaObject)
  ((reverse-role :reader reverse-role)))

(defclass MetaTag (MetaObject) ())

(defclass MetaGroup (MetaObject)())

(defclass ObjectTags ()
  ((object-id :reader object-id :initarg :object-id)
   (tags :reader tags :initform (make-hash-table))))


(defun join (separator list)
  (with-output-to-string (out)
    (loop (princ (pop list) out)
       (unless list (return))
       (princ separator out))))

(defclass Tagged ()
  ((tag-id :reader tag-id :initarg :tag-id)
   (objects :reader objects :initform (make-hash-table))))

(defun object-assoc-key (kind object-id)
  (let ((base (concatenate 'string "object" "-" kind "s")))
    (concatenate 'string base ":" object-id)))

(defun assoc-key (prefix postfix  id)
  (let ((base (concatenate 'string prefix "-" postfix "s")))
    (concatenate 'string base ":" id)))
  

(defun object-tags-key (object-id)
  (join #\: "object-tags" object-id))

(defun tag-objects-key (tag-id)
  (join #\: "tag-objects" tag-id))

(defun object-groups-key (object-id)
  (join #\: "object-groups" object-id))

(defun group-objects-key (tag-id)
  (join #\: "tag-objects" tag-id))

(defun object-tags-key (object-id)
  (join #\: "object-tags" object-id))

(defun tag-objects-key (tag-id)
  (join #\: "tag-objects" tag-id))


(defun tag-object (tag-id object-id)
  (red:sadd (assoc-key "object" "tag"  object-id) tag-id)
  (red:sadd (tag-objects-key tag-id) object-id))

(defun object-tags (object-id)
  (red:smembers (object-tags-key object-id)))
  
(defun add-object-assocs (kind object-id &rest assoc-ids)
  (red:sadd (assoc-key "object" kind object-id) assoc-ids))

(defun add-assoc-objects (kind assoc-id object-ids)
  (red:sadd (assoc-key kind  "object" assoc-id) object-ids))

(defun get-object-assocs (kind object-id)
  (red:smembers (assoc-key "object" kind object-id)))

(defun get-assoc-objects (kind assoc-id)
  (red:smembers (assoc-key kind  "object" assoc-id)))

(defun get-kind-neighbors (kind object-id)
  (let ((assoc-ids (get-object-assocs kind object-id)))
    (reduce #'union (mapcar #'get-assoc-objects assoc-ids))))

(defun get-object-neighbors (object-id &opitonal kind))
      

                     
