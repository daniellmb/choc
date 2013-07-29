(ns choc.test.readable
  (:require [wisp.ast :as ast :refer [symbol keyword symbol? keyword?]]
            [wisp.sequence :refer [cons conj list list? seq vec empty? sequential?
                                       count first second third rest last
                                       butlast take drop repeat concat reverse
                                       sort map filter reduce assoc]]
            [wisp.runtime :refer [str = dictionary]]
            [wisp.compiler :refer [self-evaluating? compile macroexpand macroexpand-1
                                       compile-program]]
            [wisp.reader :refer [read-from-string]] 
            [esprima :as esprima]
            [underscore :refer [has]]
            [util :refer [puts inspect]]
            [choc.src.util :refer [to-set set-incl? partition transpile pp parse-js when ]]
            [choc.src.readable :refer [readable-node compile-readable-entries readable-js-str]]
            ))

(defn assert-message [js wanted & opts]
  (let [o (apply dictionary opts)
        parsed (first (parse-js js))
        ; _ (pp parsed)
        readable (readable-node parsed)
        ; _ (pp readable)
        _ (print (.to-string readable))
        compiled (first (compile-readable-entries readable))
        ; _ (pp compiled)
        transpiled (transpile compiled)
        ; _ (puts transpiled) 
        ]
    (if (.hasOwnProperty o :before) (eval (:before o)))
    (eval js)
    (eval (str "var __msg = " transpiled))
    (assert (identical? (:message __msg) wanted) (str "message does not equal '" wanted "'")))
    (print (str "✓ " wanted)))

(defn assert-message-code [js wanted & opts]
  (let [o (apply dictionary opts)
        code (readable-js-str (first (parse-js js)))]
    (assert (identical? code wanted) (str "code does not equal '" wanted "'"))))

;; (print "variable declarations")

(assert-message 
 "var i = 0" 
 "Create the variable <span class='choc-variable'>i</span> and set it to <span class='choc-value'>0</span>")

; (print "\n")


;; (print "handling unknowns")
; (assert-message-code "a += 1" "[]")

;; (print "AssignmentExpression")
;; (assert-message 
;;  "foo = 1 + bar" 
;;  "set foo to 3"
;;  :before "var bar = 2, foo = 0;")

;; (assert-message 
;;  "foo += 1 + bar" 
;;  "add 3 to foo and set foo to 5"
;;  :before "var bar = 2, foo = 2;")

;; (assert-message 
;;  "bar + 1" 
;;  ""
;;  :before "var bar = 2;")

;; (assert-message 
;;  "console.log(\"hello\")" 
;;  "asdf")

