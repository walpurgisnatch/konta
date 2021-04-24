(defsystem "konta"
  :version "0.1.0"
  :author "Walpurgisnatch"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "konta"))))
  :description ""
  :in-order-to ((test-op (test-op "konta/tests"))))
