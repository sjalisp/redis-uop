;;;; redis-uop.asd

(asdf:defsystem #:redis-uop
  :description "Describe redis-uop here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-redis)
  :components ((:file "package")
               (:file "redis-uop")))
