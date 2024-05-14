/// Adds two `usize` numbers together and returns the result.
///
/// # Arguments
///
/// * `left` - The left operand for addition.
/// * `right` - The right operand for addition.
///
/// # Returns
///
/// Returns the sum of `left` and `right`.
///
/// # Examples
///
/// ```
/// use super::add;
///
/// let result = add(2, 3);
/// assert_eq!(result, 5);
/// ```
///
/// # Panics
///
/// This function will panic if the result overflows a `usize`.
///
/// # Safety
///
/// This function is safe to use with valid inputs, but may produce incorrect results if given invalid inputs or if the result overflows a `usize`.
pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        // Test basic addition functionality
        let result = add(2, 2);
        assert_eq!(result, 4);

        // Provide different values to make the assertion fail
        let result_ne = add(3, 1);
        assert_ne!(result_ne, 4);
    }
}
