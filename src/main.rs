//! This is the main function of the program.
//!
//! It prints "Hello, world!" to the standard output.
//!
//! # Examples
//!
//! ```
//! use your_crate_name::main;
//!
//! main();
//! // Output: Hello, world!
//! ```
//!
//! # Panics
//!
//! This function will panic if writing to the standard output fails.
//!
//! # Safety
//!
//! This function is safe to use under normal circumstances. However, if there are issues with the standard output stream, it may panic.
fn main() {
    println!("Hello, world!");
}
