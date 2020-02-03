#[no_mangle]
pub extern "C" fn foo(x: u32) {
    println!("foo: {}", x);
}
