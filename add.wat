;; https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format
(module
  (import "console" "log" (func $log (param i32) (param i32)))
  (import "js" "mem" (memory 1))

  (global $g (import "js" "global") (mut i32))

  ;; Write stuff into memory
  (data (i32.const 0) "Hi")
  (data (i32.const 2) "13")

  (func (export "writeHi")
    i32.const 0 ;; pass offset 0 to log
    i32.const 2 ;; pass length 2 to log
    call $log
  )

  (export "add" (func $add))
  (func (export "getAnswerPlus1") (result i32)
    call $getAnswer
    i32.const 1
    i32.add
  )
  (func (export "logIt")
    i32.const 2 ;; offset 2
    i32.const 2 ;; length 2
    call $log
  )
  (func (export "getGlobal") (result i32)
    (global.get $g)
  )
  (func (export "incGlobal")
    (global.set $g (i32.add (global.get $g) (i32.const 1)))
  )

  (func $add (param $lhs i32) (param $rhs i32) (result i32)
    local.get $lhs
    local.get $rhs
    i32.add
  )

  (func $getAnswer (result i32)
    i32.const 42
  )
)