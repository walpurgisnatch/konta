(defsystem "konta"
  :version "0.1.0"
  :author "Walpurgisnatch"
  :license "MIT"
  :depends-on ("fsw"
               "pero")
  :components ((:module "src"
                :serial t
                :components
                ((:file "daemon")
                 (:file "utils")
                 (:file "time")
                 (:file "actions")
                 (:file "job")
                 (:file "konta"))))
  :description "PDA"
  :in-order-to ((test-op (test-op "konta/tests"))))
