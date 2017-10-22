(module
    (import "js" "import1" (func $import1))
    (import "js" "import2" (func $import2))

    (import "js" "memory" (memory 1))
    (import "js" "table" (table 2 anyfunc))

    (elem (i32.const 0) $shared0func)
    (func $shared0func (result i32)
        i32.const 0
        i32.load
    )

    (elem (i32.const 1) $shared1func)
    (func $shared1func (result i32)
        i32.const 21
    )

    (type $void_to_i32 (func (result i32)))

    (func (export "doIt") (result i32)
        (i32.store (i32.const 0) (i32.const 42))
        (call_indirect $void_to_i32 (i32.const 0))
    )
    
    (func $main (call $import1))
    (start $main)
    (func (export "f") (call $import2))

    (func $getAnswer (result i32)
        (i32.const 42)
    )

    (func (export "g") (param $a i32) (param $b i32) (result i32)
        (local $c i32)
        (set_local $c (call $getAnswer))

        (i32.add 
            (get_local $c)
            (i32.add (get_local $a) (get_local $b))
        )
    )
)